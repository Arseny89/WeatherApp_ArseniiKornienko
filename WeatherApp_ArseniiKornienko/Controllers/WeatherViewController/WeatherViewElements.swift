//
//  WeatherViewElements.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 12/5/24.
//

import Foundation
import UIKit

enum WeatherViewElements {
    case dayTemp
    case tempRange
    
    
    var title: String {
        switch self {
        case .dayTemp: return "HOURLY FORECAST"
        case .tempRange: return "5-DAY FORECAST"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .dayTemp:
            return UIImage(icon: .clock)?.withConfiguration(
                UIImage.SymbolConfiguration(weight: .heavy)
            ) ?? UIImage.checkmark
        case .tempRange:
            return UIImage(icon: .calendar)?.withConfiguration(
                UIImage.SymbolConfiguration(weight: .heavy)
            ) ?? UIImage.checkmark
        }
    }
}
