//
//  CityData.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/9/24.
//

import Foundation

struct CityData: Codable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coordinates: Coordinates
    
    enum CodingKeys: String, CodingKey {
        case name
        case country
        case coordinates = "coord"
        case state
        case id
    }
    
    var weatherData: CityWeatherData {
        CityWeatherData(id: id,
                        titleData: TitleData(title: name,
                                             subtitle: nil,
                                             currentTemp: nil,
                                             description: nil,
                                             minTemp: nil,
                                             maxTemp: nil,
                                             backgroundImage: nil),
                        dayTempData: nil,
                        tempRangeData: nil)
    }
}
