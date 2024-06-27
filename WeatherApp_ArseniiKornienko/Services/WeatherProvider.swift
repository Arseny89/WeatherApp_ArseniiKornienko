//
//  WeatherProvider.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/5/24.
//

import UIKit
import SnapKit

protocol WeatherProviderDelegate: AnyObject {
    func setCurrentWeather(_ data: [Int: CityWeatherData])
    func setAlertMessage(_ message: String)
}

protocol WeatherProvider {
    var delegate: WeatherProviderDelegate? { get set }
    func getDataForCityList(_ data: [CityData], forced: Bool, 
                            completionHandler: @escaping ([Int: CityWeatherData]) -> Void)
    func appMovedToBackground()
}

final class WeatherProviderImpl: WeatherProvider {
    weak var delegate: WeatherProviderDelegate?
    var currentCityId = 5352423
    
    var weatherCache: [Int: CurrentWeatherResponse] = [:]
    var weatherDataCache: [Int: CityWeatherData] = [:]
    var forecastCache: [Int: ForecastResponse] = [:]
    var currentCityWeather: CityWeatherData?
    var currentCityList: [Int: CityWeatherData] = [:]
    private let storageManager = StorageManager()
    private let dataProvider = APIDataProvider()
    private var notificationCenter = NotificationCenter.default
    private var isNeedUploadNewWeatherData: Bool {
        guard let prevUploadData: Date = storageManager.object(for: .weatherUploadDate),
              let nextUploadDate = Calendar.current.date(byAdding: .hour, value: 1, to: prevUploadData) else {
            return true
        }
        
        return weatherDataCache.isEmpty || nextUploadDate < Date()
    }
    func appMovedToBackground() {
        notificationCenter.addObserver(
            self, selector: #selector(notificate),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }
    
    func getData<T: Decodable>(for coordinates: Coordinates, response: T.Type,
                               completion: @escaping (T) -> Void,
                               errorHandler: @escaping (AppError) -> Void?) {
        let endpoint: Endpoint
        if response == CurrentWeatherResponse.self {
            endpoint = .currentWeather(lat: coordinates.latitude,
                                       lon: coordinates.longitude)
        } else {
            endpoint = .forecast(lat: coordinates.latitude,
                                 lon: coordinates.longitude)
        }
        dataProvider.getData(endpoint,
                             completion: completion,
                             errorHandler: errorHandler)
    }
    
    func prepareCityWeatherData(for id: Int) -> CityWeatherData {
        guard let weatherData = weatherCache[id] else { return .emptyData}
        let title =  id == currentCityId ? "My Location" : weatherData.name
        let subtitle = id == currentCityId
        ? weatherData.name
        ?? "\(weatherData.coordinates.latitude) \(weatherData.coordinates.longitude)"
        : nil
        
        let titleData = TitleData(title: title,
                                  subtitle: subtitle,
                                  currentTemp: weatherData.main.temp,
                                  description: weatherData.weather.first?.description.capitalized,
                                  minTemp: weatherData.main.minTemp,
                                  maxTemp: weatherData.main.maxTemp,
                                  backgroundImage: UIImage(image: .sunSky))
        
        return CityWeatherData(id: id,
                               titleData: titleData,
                               dayTempData: prepareDayTempData(for: forecastCache[id]),
                               tempRangeData: prepareDayData(for: forecastCache[id], and: weatherCache[id]!))
    }
    
    func prepareDayTempData(for forecast: ForecastResponse?) -> [DayTempData]? {
        guard let forecast else { return nil }
        var calendar = Calendar.current
        calendar.timeZone = forecast.city.timezone
        var tempData = forecast.list.map { item in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH"
            dateFormatter.timeZone = forecast.city.timezone
            
            return DayTempData(date: item.date,
                               icon: item.weather.first?.icon.image.withRenderingMode(.alwaysOriginal),
                               temp: item.main.temp,
                               time: dateFormatter.string(from: item.date))
        }
        let nowDate = Date()
        tempData.append(DayTempData(date: nowDate,
                                    icon: tempData.first?.icon?.withRenderingMode(.alwaysOriginal),
                                    temp: tempData.first?.temp ?? 0,
                                    time: "Сейчас"))
        
        return tempData
            .sorted { $0.date < $1.date }
            .filter { item in
                item.date >= nowDate
                && item.date <= calendar.nextDay(for: nowDate)
            }
    }
    
    func getDataForCityList(_ list: [CityData], forced: Bool, completionHandler: @escaping ([Int: CityWeatherData]) -> Void) {
        if isNeedUploadNewWeatherData || forced {
            var cityListWeather: [Int: CityWeatherData] = [:]
            list.enumerated().forEach { index, data in
                getData(for: data.coordinates, response: ForecastResponse.self) { [weak self] forecast in
                    guard let self else { return }
                    forecastCache[data.id] = forecast
                } errorHandler: { [weak self] error in
                    guard let self else { return }
                    let errorMessage = error.description
                    delegate?.setAlertMessage(errorMessage)
                }
                getData(for: data.coordinates,
                        response: CurrentWeatherResponse.self)
                {[weak self] currentWeather in
                    guard let self else { return }
                    weatherCache[data.id] = currentWeather
                    let weatherData = prepareCityWeatherData(for: data.id)
                    cityListWeather[data.id] = weatherData
                    completionHandler(cityListWeather)
                } errorHandler: { [weak self] error in
                    guard let self else { return }
                    let errorMessage = error.description
                    delegate?.setAlertMessage(errorMessage)
                }
            }
            storageManager.set(Date(), .weatherUploadDate)
        } else {
            delegate?.setCurrentWeather(weatherDataCache)
        }
    }
    
    func prepareDayData(for forecast: ForecastResponse?, and weatherData: CurrentWeatherResponse) -> [TempRangeData]? {
        guard let forecast else { return nil }
        var calendar = Calendar.current
        calendar.timeZone = forecast.city.timezone
        
        var tempData: [Int: [HourlyWeatherItem]] = [:]
        forecast.list.forEach { item in
            let day = calendar.component(.day, from: item.date)
            
            if var dates = tempData[day]{
                dates.append(item)
                tempData[day] = dates
            } else {
                tempData[day] = [item]
            }
        }
        
        let minTemp = forecast.list.map { $0.main.minTemp }.min() ?? 0
        let maxTemp = forecast.list.map { $0.main.maxTemp }.max() ?? 1
        
        let dayData = tempData
            .sorted { $0.key < $1.key }
            .map { key, items in
                let minDayTemp = items.map { $0.main.minTemp }.min() ?? 0
                let maxDayTemp = items.map { $0.main.maxTemp }.max() ?? 1
                
                let todayKey = calendar.component(.day, from: Date())
                if key == todayKey {
                    return TempRangeData(day: "Today",
                                         icon: weatherData.weather.first?.icon.image
                        .withRenderingMode(.alwaysOriginal),
                                         minDayTemp: minDayTemp,
                                         maxDayTemp: maxDayTemp,
                                         minTemp: minTemp, // Data not available
                                         maxTemp: maxTemp, // Data not available
                                         currentTemp: weatherData.main.temp
                    )
                } else {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "EEE"
                    dateFormatter.timeZone = forecast.city.timezone
                    
                    return TempRangeData(day: dateFormatter.string(from: items.first?.date ?? Date()),
                                         icon: items.first?.weather.first?.icon.image
                        .withRenderingMode(.alwaysOriginal),
                                         minDayTemp: minDayTemp,
                                         maxDayTemp: maxDayTemp,
                                         minTemp: minTemp,
                                         maxTemp: maxTemp,
                                         currentTemp: nil)
                }
            }
        return dayData
    }
    
    @objc func notificate() {
        print("App moved to background")
    }
}

fileprivate extension Calendar {
    func nextDay(for date: Date) -> Date {
        self.date(byAdding: .day, value: 1, to: date) ?? date
    }
}
