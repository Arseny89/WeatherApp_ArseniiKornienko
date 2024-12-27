//
//  WeatherData.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/13/24.
//

import Foundation
import UIKit

struct WeatherConditions: Decodable {
    let main: String
    let description: String
    let visual: Conditions
    
    enum CodingKeys: String, CodingKey {
        case main
        case description
        case visual = "icon"
    }
}

extension WeatherConditions {
    enum Conditions: String, Decodable {
        case clearSkyDay = "01d"
        case clearSkyNight = "01n"
        case fewCloudsDay = "02d"
        case fewCloudsNight = "02n"
        case scatteredCloudsDay = "03d"
        case scatteredCloudsNight = "03n"
        case brokenCloudsDay = "04d"
        case brokenCloudsNight = "04n"
        case showerRainDay = "09d"
        case showerRainNight = "09n"
        case rainDay = "10d"
        case rainNight = "10n"
        case thunderstormDay = "11d"
        case thunderstormNight = "11n"
        case snowDay = "13d"
        case snowNight = "13n"
        case mistDay = "50d"
        case mistNight = "50n"
        
        var icon: UIImage {
            switch self {
            case .clearSkyDay: return UIImage(icon: .sunMax) ?? UIImage.checkmark
            case .clearSkyNight: return UIImage(icon: .moonStars) ?? UIImage.checkmark
            case .fewCloudsDay: return UIImage(icon: .cloudSun) ?? UIImage.checkmark
            case .fewCloudsNight: return UIImage(icon: .cloudMoon) ?? UIImage.checkmark
            case .scatteredCloudsDay,
                    .brokenCloudsDay,
                    .brokenCloudsNight,
                    .scatteredCloudsNight: return UIImage(icon: .cloud) ?? UIImage.checkmark
            case .showerRainDay,
                    .showerRainNight,
                    .rainDay,
                    .rainNight: return UIImage(icon: .cloudRain) ?? UIImage.checkmark
            case .thunderstormDay,
                    .thunderstormNight: return UIImage(icon: .thunder) ?? UIImage.checkmark
            case .snowDay,
                    .snowNight: return UIImage(icon: .snow) ?? UIImage.checkmark
            case .mistDay,
                    .mistNight: return UIImage(icon: .mist) ?? UIImage.checkmark
                
            }
        }
        
        var image: UIImage {
            switch self {
            case .clearSkyDay: return UIImage(image: .sunSky) ?? UIImage.checkmark
            case .clearSkyNight: return UIImage(image: .starNight) ?? UIImage.checkmark
            case .fewCloudsDay,
                    .scatteredCloudsDay,
                    .brokenCloudsDay: return UIImage(image: .clouds) ?? UIImage.checkmark
            case .fewCloudsNight,
                    .brokenCloudsNight,
                    .scatteredCloudsNight: return UIImage(image: .cloudNight) ?? UIImage.checkmark
            case .showerRainDay,
                    .rainDay: return UIImage(image: .rainDay) ?? UIImage.checkmark
            case .rainNight,
                    .showerRainNight: return UIImage(image: .rainDay) ?? UIImage.checkmark
            case .thunderstormDay,
                    .thunderstormNight: return UIImage(image: .clouds) ?? UIImage.checkmark
            case .snowDay,
                    .snowNight: return UIImage(image: .clouds) ?? UIImage.checkmark
            case .mistDay,
                    .mistNight: return UIImage(image: .clouds) ?? UIImage.checkmark
            }
        }
    }
}
