//
//  WeatherProvider.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/5/24.
//

import UIKit
import SnapKit

protocol WeatherProviderDelegate: AnyObject {
    func setCurrentWeather(_ data: [CityWeatherData])
    func setAlertMessage(_ message: String)
}

final class WeatherProvider {
    weak var delegate: WeatherProviderDelegate?
    let currentCoordinates = (lat: 34.142509, lon: -118.255081)
    var currentCityId = 5352423
    var weatherCache: [Int: CurrentWeatherResponse] = [:]
    var weatherDataCache: [Int: CityWeatherData] = [:]
    var forecastCache: [Int: ForecastResponse] = [:]
    var currentCityWeather: CityWeatherData?
    private let dataProvider = APIDataProvider()
    private var notificationCenter = NotificationCenter.default
    func appMovedToBackground() {
        notificationCenter.addObserver(
            self, selector: #selector(notificate),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }
    
    func sceneWillEnterForeground() {
        let id = currentCityId
        getData(for: currentCityId,
                response: ForecastResponse.self)
        { [weak self] forecast in
            guard let self else { return }
            forecastCache[id] = forecast
        } errorHandler: { error in
        }
        
        getData(for: currentCityId,
                response: CurrentWeatherResponse.self)
        {[weak self] currentWeather in
            guard let self else { return }
            weatherCache[id] = currentWeather
            let weatherData = prepareCityWeatherData(for: id)
            weatherDataCache[id] = weatherData
            delegate?.setCurrentWeather([weatherData])
        } errorHandler: { [weak self] error in
            guard let self else { return }
            let errorMessage = error.description
            delegate?.setAlertMessage(errorMessage)
        }
    }
    
    func getData<T: Decodable>(for id: Int, response: T.Type,
                               completion: @escaping (T) -> Void,
                               errorHandler: @escaping (AppError) -> Void?) {
        let endpoint: Endpoint
        if response == CurrentWeatherResponse.self {
            endpoint = id == currentCityId ?
                .currentWeather(lat: currentCoordinates.lat,
                                lon: currentCoordinates.lon) :
                .currentWeatherId(id: id)
        } else {
            endpoint = id == currentCityId ?
                .forecast(lat: currentCoordinates.lat,
                          lon: currentCoordinates.lon) :
                .forecastId(id: id)
        }
        dataProvider.getData(endpoint,
                             completion: completion,
                             errorHandler: errorHandler)
    }
    
    func prepareCityWeatherData(for id: Int) -> CityWeatherData {
        guard let weatherData = weatherCache[id] else { return .emptyData}
        let title =  id == currentCityId ? "Текущее место" : weatherData.name
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
                               tempRangeData: nil)
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
    
    @objc func notificate() {
        print("App moved to background")
    }
}

fileprivate extension Calendar {
    func nextDay(for date: Date) -> Date {
        self.date(byAdding: .day, value: 1, to: date) ?? date
    }
}
