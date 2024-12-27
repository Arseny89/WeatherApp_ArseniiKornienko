//
//  MOCKDataProvider.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/19/24.
//

import UIKit

struct CityWeatherData: Hashable {
    let id: Int?
    let titleData: TitleData
    let dayTempData: [DayTempData]?
    let tempRangeData: [TempRangeData]?
}

struct TitleData: Hashable {
    let title: String?
    let subtitle: String?
    let currentTemp: Double?
    let description: String?
    let minTemp: Double?
    let maxTemp: Double?
    let backgroundImage: UIImage?
}

struct DayTempData: Hashable {
    let date: Date
    let icon: UIImage?
    let temp: Double?
    let time: String
}

struct TempRangeData: Hashable {
    let day: String
    let icon: UIImage?
    let minDayTemp: Double
    let maxDayTemp: Double
    let minTemp: Double
    let maxTemp: Double
    let currentTemp: Double?
    let dateUnix: Double?
}

private let sunIcon = UIImage(icon: .sunMax)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
private let moonIcon = UIImage(icon: .moonStars)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
private let cloudIcon = UIImage(icon: .cloud)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
private let cloudMoonIcon = UIImage(icon: .cloudMoon)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
private let cloudSunIcon = UIImage(icon: .cloudSun)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
private let windIcon = UIImage(icon: .wind)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
private let cloudRainIcon = UIImage(icon: .cloudRain)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark

private let sunSkyImage = UIImage(image: .sunSky) ?? UIImage.checkmark
private let cloudNightImage = UIImage(image: .cloudNight) ?? UIImage.checkmark
private let starNightImage = UIImage(image: .starNight) ?? UIImage.checkmark
private let cloudsImage = UIImage(image: .clouds) ?? UIImage.checkmark
private let cloudsGreyImage = UIImage(image: .cloudsGrey) ?? UIImage.checkmark


extension CityWeatherData {
    static var emptyData: CityWeatherData {
        CityWeatherData(
            id: nil,
            titleData: TitleData(title: "--",
                                 subtitle: "--",
                                 currentTemp: nil,
                                 description: "--",
                                 minTemp: nil,
                                 maxTemp: nil,
                                 backgroundImage: nil),
            dayTempData: nil,
            tempRangeData: nil
        )
    }
}

extension DayTempData {
    static var emptyData: DayTempData {
        DayTempData(date: Date(),
                    icon: nil,
                    temp: nil,
                    time: "--")
    }
}
