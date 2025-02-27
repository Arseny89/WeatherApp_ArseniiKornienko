//
//  Image Extension.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/16/24.
//

import UIKit

extension UIImage {
    
    convenience init?(icon: Icons) {
        self.init(systemName: icon.rawValue)
    }
    
    convenience init?(image: Images) {
        self.init(named: image.rawValue)
    }
    
    enum Icons: String {
        case cloudSun = "cloud.sun.fill"
        case xmarkCircle = "xmark.circle.fill"
        case ellipsisCircle = "ellipsis.circle"
        case infoCircle = "info.circle"
        case calendar = "calendar"
        case listBullet = "list.bullet"
        case sunMax = "sun.max.fill"
        case moonStars = "moon.stars.fill"
        case cloud = "cloud.fill"
        case cloudMoon = "cloud.moon.fill"
        case infoSquare = "info.square"
        case wind = "wind"
        case cloudRain = "cloud.rain.fill"
        case micIcon = "mic.fill"
        case clock = "clock"
        case mist = "cloud.fog.fill"
        case snow = "snowflake"
        case thunder = "cloud.bolt.fill"
        case trash = "trash"
    }
    
    enum Images: String {
        case sunSky = "sunSky"
        case cloudNight = "cloudNight"
        case clouds = "clouds"
        case starNight = "starNight"
        case cloudsGrey = "cloudsGrey"
        case rainDay = "rainDay"
    }
}
