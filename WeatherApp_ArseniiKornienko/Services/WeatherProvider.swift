//
//  WeatherProvider.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/5/24.
//

import UIKit
import SnapKit

protocol WeatherProviderDelegate: AnyObject {
    func setCurrentWeather(_ currentWeather: [MOCKData])
}

final class WeatherProvider {
    weak var delegate: WeatherProviderDelegate?
    var currentWeatherData: [MOCKData] = []
    private var notificationCenter = NotificationCenter.default
    
    func appMovedToBackground() {
        notificationCenter.addObserver(
            self, selector: #selector(notificate),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }
    
    func getCurrentWeather() {
        delegate?.setCurrentWeather(MOCKData.data)
        currentWeatherData = MOCKData.data
    }
    
    @objc func notificate() {
        print("App moved to background")
    }
}
