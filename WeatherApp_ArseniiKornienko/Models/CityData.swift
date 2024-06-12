//
//  CityData.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/9/24.
//

import Foundation

struct CityData: Codable {
    let name: String
    let state: String
    let country: String
    let coordinates: Coordinates
    
    enum CodingKeys: String, CodingKey {
        case name
        case country
        case coordinates = "coord"
        case state
    }
}
