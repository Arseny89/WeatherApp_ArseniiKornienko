//
//  ForecastResponse.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/9/24.
//

import Foundation

struct ForecastResponse: Decodable {
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
    let timezone: TimeZone
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
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
        self.country = try container.decode(String.self, forKey: .country)
        
        let timeZoneValue = try container.decode(Int.self, forKey: .timezone)
        self.timezone = TimeZone(secondsFromGMT: timeZoneValue) ?? TimeZone.current
        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
    }
}

struct Coordinates: Codable, Equatable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}

struct HourlyWeatherItem: Decodable {
    let main: WeatherItem
    let date: Date
    let weather: [WeatherConditions]
    
    enum CodingKeys: String, CodingKey {
        case main
        case dateUnix = "dt"
        case weather
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.main = try container.decode(WeatherItem.self, forKey: .main)
        let dateUnix = try container.decode(Double.self, forKey: .dateUnix)
        self.date = Date(timeIntervalSince1970: dateUnix)
        self.weather = try container.decode([WeatherConditions].self, forKey: .weather)
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
