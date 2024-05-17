//
//  Image Extension.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/16/24.
//

import UIKit

extension UIImage {
    enum Images {
        case cloudSun
        case xmarkCircle
        case ellipsisCircle
        case infoCircle
        case sky
        case calendar
        case listBullet
        case sunMax
        case moonStars
        
        var image: UIImage? {
            switch self {
            case .cloudSun: return UIImage(systemName: "cloud.sun.fill")
            case .xmarkCircle: return UIImage(systemName: "xmark.circle.fill")
            case .ellipsisCircle: return UIImage(systemName: "ellipsis.circle")
            case .infoCircle: return UIImage(systemName: "info.circle")
            case .sky: return UIImage(named: "sky")
            case .calendar: return UIImage(systemName: "calendar")
            case .listBullet: return UIImage(systemName: "list.bullet")
            case .sunMax: return UIImage(systemName: "sun.max.fill")
            case .moonStars: return UIImage(systemName: "moon.stars.fill")
            }
        }
    }
}
