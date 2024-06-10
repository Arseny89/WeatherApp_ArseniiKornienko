//
//  ForecastResponse.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/9/24.
//

import Foundation

struct ForecastResponse: Codable {
    let count: Int
    let city: City
    let list: [HourlyWeatherItem]
    
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case city
        case list
    }
}

struct City: Codable {
    let name: String
    let coordinates: Coordinates
    let country: String
    let timezone: Int
    let sunrise: Int
    let sunset: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case coordinates = "coord"
        case country
        case timezone
        case sunrise
        case sunset
    }
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}

struct HourlyWeatherItem: Codable {
    let main: WeatherItem
    let dateText: String
    let weather: [WeatherConditions]
    
    enum CodingKeys: String, CodingKey {
        case main
        case dateText = "dt_txt"
        case weather
    }
}

struct WeatherItem: Codable {
    let temp: Double
    let maxTemp: Double
    let minTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case maxTemp = "temp_max"
        case minTemp = "temp_min"
    }
}

struct WeatherConditions: Codable {
    let main: String
    let description: String
    let icon: String
}
