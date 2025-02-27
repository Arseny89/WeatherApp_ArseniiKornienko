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
    var weatherCache: [Int: CurrentWeatherResponse] = [:]
    var weatherDataCache: [Int: CityWeatherData] = [:]
    var forecastCache: [Int: ForecastResponse] = [:]
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
    
    func getDataForCityList(_ list: [CityData],
                            forced: Bool,
                            completionHandler: @escaping ([Int: CityWeatherData]) -> Void) {
        if isNeedUploadNewWeatherData || forced {
            var cityListWeather: [Int: CityWeatherData] = [:]
            let group = DispatchGroup()
            list.forEach { data in
                group.enter()
                getDataForCity(from: data) { cityWeather in
                    cityListWeather[data.id] = cityWeather
                    group.leave()
                }
            }
            group.notify(queue: .main) {
                completionHandler(cityListWeather)
            }
            storageManager.set(Date(), .weatherUploadDate)
        } else {
            delegate?.setCurrentWeather(weatherDataCache)
        }
    }
    
    private func getData<T: Decodable>(for coordinates: Coordinates, response: T.Type,
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
    
    private func prepareCityWeatherData(for id: Int) -> CityWeatherData? {
        guard let weatherData = weatherCache[id] else { return nil }
        
        let title =  weatherData.name ?? "\(weatherData.coordinates.latitude) \(weatherData.coordinates.longitude)"
        let subtitle = id == .currentCityId ? "My Location" : nil
        let titleData = TitleData(title: title,
                                  subtitle: subtitle,
                                  currentTemp: weatherData.main.temp,
                                  description: weatherData.weather.first?.description.capitalized,
                                  minTemp: weatherData.main.minTemp,
                                  maxTemp: weatherData.main.maxTemp,
                                  backgroundImage: weatherData.weather.first?.visual.image)
        
        return CityWeatherData(id: id,
                               titleData: titleData,
                               dayTempData: prepareDayTempData(for: forecastCache[id]),
                               tempRangeData: prepareDayData(for: forecastCache[id], and: weatherData))
    }
    
    private func prepareDayTempData(for forecast: ForecastResponse?) -> [DayTempData]? {
        guard let forecast else { return nil }
        
        var calendar = Calendar.current
        calendar.timeZone = forecast.city.timezone
        var tempData = forecast.list.map { item in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH"
            dateFormatter.timeZone = forecast.city.timezone
            
            return DayTempData(date: item.date,
                               icon: item.weather.first?.visual.icon.withRenderingMode(.alwaysOriginal),
                               temp: item.main.temp,
                               time: dateFormatter.string(from: item.date))
        }
        let nowDate = Date()
        tempData.append(DayTempData(date: nowDate,
                                    icon: tempData.first?.icon?.withRenderingMode(.alwaysOriginal),
                                    temp: tempData.first?.temp ?? 0,
                                    time: "Now"))
        
        return tempData
            .sorted { $0.date < $1.date }
            .filter { item in
                item.date >= nowDate
                && item.date <= calendar.nextDay(for: nowDate)
            }
    }
    
    private func prepareDayData(for forecast: ForecastResponse?, and weatherData: CurrentWeatherResponse) -> [TempRangeData]? {
        guard let forecast else { return nil }
        var calendar = Calendar.current
        calendar.timeZone = forecast.city.timezone
        
        var tempData: [Int: [HourlyWeatherItem]] = [:]
        forecast.list.forEach { item in
            let day = calendar.component(.day, from: item.date)

                if var dates = tempData[day] {
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
                
                let todayMinTemp = minTemp + abs(weatherData.main.temp - minTemp) / 2
                let todayMaxTemp = maxTemp - abs(maxTemp - weatherData.main.temp) / 2
                let todayKey = calendar.component(.day, from: Date())
                if key == todayKey {
                    return TempRangeData(day: "Today",
                                         icon: weatherData.weather.first?.visual.icon
                        .withRenderingMode(.alwaysOriginal),
                                         minDayTemp: todayMinTemp,
                                         maxDayTemp: todayMaxTemp,
                                         minTemp: minTemp,
                                         maxTemp: maxTemp,
                                         currentTemp: weatherData.main.temp,
                                         dateUnix: items.first?.dateUnix
                    )
                } else {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "EEE"
                    dateFormatter.timeZone = forecast.city.timezone
                    
                    return TempRangeData(day: dateFormatter.string(from: items.first?.date ?? Date()),
                                         icon: items.first?.weather.first?.visual.icon
                        .withRenderingMode(.alwaysOriginal),
                                         minDayTemp: minDayTemp,
                                         maxDayTemp: maxDayTemp,
                                         minTemp: minTemp,
                                         maxTemp: maxTemp,
                                         currentTemp: nil,
                                         dateUnix: items.first?.dateUnix)
                }
            }
        return dayData.sorted { $0.dateUnix ?? 0 < $1.dateUnix ?? 0 }
    }
    
    private func getDataForCity(from data: CityData, completionHandler: @escaping (CityWeatherData) -> Void) {
        var cityWeather: CityWeatherData = .emptyData
        getData(for: data.coordinates,
                response: ForecastResponse.self) { [weak self] forecast in
            guard let self else { return }
            
            forecastCache[data.id] = forecast
            
            getData(for: data.coordinates,
                    response: CurrentWeatherResponse.self) { [weak self] currentWeather in
                guard let self else { return }
                
                weatherCache[data.id] = currentWeather
                cityWeather = prepareCityWeatherData(for: data.id) ?? .emptyData
                completionHandler(cityWeather)
            } errorHandler: { [weak self] error in
                guard let self else { return }
                let errorMessage = error.description
                delegate?.setAlertMessage(errorMessage)
            }
        } errorHandler: { [weak self] error in
            guard let self else { return }
            let errorMessage = error.description
            delegate?.setAlertMessage(errorMessage)
        }
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
