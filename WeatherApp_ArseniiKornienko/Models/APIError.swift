//
//  AppError.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/14/24.
//

import Foundation

struct APIError: Decodable {
    let code: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case message
    }
}
