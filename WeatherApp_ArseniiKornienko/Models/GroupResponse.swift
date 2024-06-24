//
//  GroupResponse.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/21/24.
//
import Foundation

struct GroupResponse: Decodable {
    let count: Int
    let list: [CurrentWeatherResponse]
    
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case list
    }
}

