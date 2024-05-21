//
//  MOCKDataProvider.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/19/24.
//

import UIKit

typealias TitleData = CurrentWeatherView.InputData
typealias DayTempData = DayTempView.InputData
typealias TempRangeData = TempRangeView.InputData

struct MOCKData {
    
    enum Constants: Int {
        case title
        case subtitle
        case titleDescription
        case dayDescription
        case currentTemp
        case currentMinTemp
        case currentMaxTemp
        case minTemp
        case maxTemp
        
        var currentText: String {
            switch self {
            case .title: return "Текущее место"
            case .subtitle: return "Glendale"
            case .titleDescription: return "Солнечно"
            case .dayDescription: return "Преимущественно солнечно"
            default: return "No text"
            }
        }
        
        var currentValue: Double {
            switch self {
            case .currentTemp: return 25
            case .currentMinTemp: return 16
            case .currentMaxTemp: return 25
            case .minTemp: return 13
            case .maxTemp: return 28
            default: return 0
            }
        }
        
        var secondText: String {
            switch self {
            case .title: return "Moscow"
            case .subtitle: return "12:00 PM"
            case .titleDescription: return "Облачно"
            case .dayDescription: return "Преимущественно облачно"
            default: return "No text"
            }
        }
        
        var secondValue: Double {
            switch self {
            case .currentTemp: return 20
            case .currentMinTemp: return 13
            case .currentMaxTemp: return 21
            case .minTemp: return 10
            case .maxTemp: return 22
            default: return 0
            }
        }
        
        var thirdText: String {
            switch self {
            case .title: return "Mexico City"
            case .subtitle: return "15:00 PM"
            case .titleDescription: return "Солнечно"
            case .dayDescription: return "Преимущественно солнечно"
            default: return "No text"
            }
        }
        
        var thirdValue: Double {
            switch self {
            case .currentTemp: return 27
            case .currentMinTemp: return 19
            case .currentMaxTemp: return 28
            case .minTemp: return 15
            case .maxTemp: return 29
            default: return 0
            }
        }
        
    }
    
    let titleData: TitleData
    let dayTempData: (description: String, data: [DayTempData])
    let tempRangeData: [TempRangeData]
}

private let sunIcon = UIImage(icon: .sunMax)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
private let moonIcon = UIImage(icon: .moonStars)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
private let cloudIcon = UIImage(icon: .cloud)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
private let cloudMoonIcon = UIImage(icon: .cloudMoon)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark

extension MOCKData {
    static var data: [MOCKData] {
        return [
            //MARK: Current city
            MOCKData(titleData: TitleData(title: Constants.title.currentText,
                                          subtitle: Constants.subtitle.currentText,
                                          currentTemp: Int(Constants.currentTemp.currentValue),
                                          description: Constants.titleDescription.currentText,
                                          minTemp: Int(Constants.currentMinTemp.currentValue),
                                          maxTemp: Int(Constants.currentMaxTemp.currentValue)),
                     dayTempData: (description: Constants.dayDescription.currentText,
                                   data: [DayTempData(icon: sunIcon,
                                                      temp: 25,
                                                      time: "Сейчас"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 25,
                                                      time: "15"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 24,
                                                      time: "16"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 24,
                                                      time: "17"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 23,
                                                      time: "18"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 21,
                                                      time: "19"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 20,
                                                      time: "20"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 18,
                                                      time: "21"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 16,
                                                      time: "22"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 16,
                                                      time: "23"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 16,
                                                      time: "00"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 15,
                                                      time: "01"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 15,
                                                      time: "02")]),
                     tempRangeData: [TempRangeData(day: "Сегодня",
                                                   icon: sunIcon,
                                                   minDayTemp: Constants.currentMinTemp.currentValue,
                                                   maxDayTemp: Constants.currentMaxTemp.currentValue,
                                                   minTemp: Constants.minTemp.currentValue,
                                                   maxTemp: Constants.maxTemp.currentValue,
                                                   currentTemp: Constants.currentTemp.currentValue),
                                     TempRangeData(day: "Вт",
                                                   icon: sunIcon,
                                                   minDayTemp: 15,
                                                   maxDayTemp: 23,
                                                   minTemp: Constants.minTemp.currentValue,
                                                   maxTemp: Constants.maxTemp.currentValue),
                                     TempRangeData(day: "Ср",
                                                   icon: sunIcon,
                                                   minDayTemp: 15,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.currentValue,
                                                   maxTemp: Constants.maxTemp.currentValue),
                                     TempRangeData(day: "Чт",
                                                   icon: sunIcon,
                                                   minDayTemp: 17,
                                                   maxDayTemp: 25,
                                                   minTemp: Constants.minTemp.currentValue,
                                                   maxTemp: Constants.maxTemp.currentValue),
                                     TempRangeData(day: "Пт",
                                                   icon: sunIcon,
                                                   minDayTemp: 17,
                                                   maxDayTemp: 28,
                                                   minTemp: Constants.minTemp.currentValue,
                                                   maxTemp: Constants.maxTemp.currentValue),
                                     TempRangeData(day: "Сб",
                                                   icon: sunIcon,
                                                   minDayTemp: 19,
                                                   maxDayTemp: 28,
                                                   minTemp: Constants.minTemp.currentValue,
                                                   maxTemp: Constants.maxTemp.currentValue),
                                     TempRangeData(day: "Вс",
                                                   icon: sunIcon,
                                                   minDayTemp: 17,
                                                   maxDayTemp: 25,
                                                   minTemp: Constants.minTemp.currentValue,
                                                   maxTemp: Constants.maxTemp.currentValue),
                                     TempRangeData(day: "Пн",
                                                   icon: sunIcon,
                                                   minDayTemp: 16,
                                                   maxDayTemp: 24,
                                                   minTemp: Constants.minTemp.currentValue,
                                                   maxTemp: Constants.maxTemp.currentValue),
                                     TempRangeData(day: "Вт",
                                                   icon: sunIcon,
                                                   minDayTemp: 17,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.currentValue,
                                                   maxTemp: Constants.maxTemp.currentValue),
                                     TempRangeData(day: "Ср",
                                                   icon: sunIcon,
                                                   minDayTemp: 18,
                                                   maxDayTemp: 25,
                                                   minTemp: Constants.minTemp.currentValue,
                                                   maxTemp: Constants.maxTemp.currentValue)
                     ]),
            //MARK: Second city
            MOCKData(titleData: TitleData(title: Constants.title.secondText,
                                          subtitle: Constants.subtitle.secondText,
                                          currentTemp: Int(Constants.currentTemp.secondValue),
                                          description: Constants.titleDescription.secondText,
                                          minTemp: Int(Constants.currentMinTemp.secondValue),
                                          maxTemp: Int(Constants.currentMaxTemp.secondValue)),
                     dayTempData: (description: Constants.dayDescription.secondText,
                                   data: [DayTempData(icon: cloudIcon,
                                                      temp: 22,
                                                      time: "Сейчас"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 22,
                                                      time: "13"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 21,
                                                      time: "14"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 21,
                                                      time: "15"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 21,
                                                      time: "16"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 19,
                                                      time: "17"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 19,
                                                      time: "18"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 19,
                                                      time: "19"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 18,
                                                      time: "20"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 16,
                                                      time: "21"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 14,
                                                      time: "22"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 13,
                                                      time: "23"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 12,
                                                      time: "00")]),
                     tempRangeData: [TempRangeData(day: "Сегодня",
                                                   icon: cloudIcon,
                                                   minDayTemp: Constants.currentMinTemp.secondValue,
                                                   maxDayTemp: Constants.currentMaxTemp.secondValue,
                                                   minTemp: Constants.minTemp.secondValue,
                                                   maxTemp: Constants.maxTemp.secondValue,
                                                   currentTemp: Constants.currentTemp.secondValue),
                                     TempRangeData(day: "Вт",
                                                   icon: cloudIcon,
                                                   minDayTemp: 12,
                                                   maxDayTemp: 20,
                                                   minTemp: Constants.minTemp.secondValue,
                                                   maxTemp: Constants.maxTemp.secondValue),
                                     TempRangeData(day: "Ср",
                                                   icon: sunIcon,
                                                   minDayTemp: 13,
                                                   maxDayTemp: 21,
                                                   minTemp: Constants.minTemp.secondValue,
                                                   maxTemp: Constants.maxTemp.secondValue),
                                     TempRangeData(day: "Чт",
                                                   icon: sunIcon,
                                                   minDayTemp: 14,
                                                   maxDayTemp: 23,
                                                   minTemp: Constants.minTemp.secondValue,
                                                   maxTemp: Constants.maxTemp.secondValue),
                                     TempRangeData(day: "Пт",
                                                   icon: sunIcon,
                                                   minDayTemp: 14,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.secondValue,
                                                   maxTemp: Constants.maxTemp.secondValue),
                                     TempRangeData(day: "Сб",
                                                   icon: sunIcon,
                                                   minDayTemp: 12,
                                                   maxDayTemp: 20,
                                                   minTemp: Constants.minTemp.secondValue,
                                                   maxTemp: Constants.maxTemp.secondValue),
                                     TempRangeData(day: "Вс",
                                                   icon: cloudIcon,
                                                   minDayTemp: 12,
                                                   maxDayTemp: 19,
                                                   minTemp: Constants.minTemp.secondValue,
                                                   maxTemp: Constants.maxTemp.secondValue),
                                     TempRangeData(day: "Пн",
                                                   icon: sunIcon,
                                                   minDayTemp: 13,
                                                   maxDayTemp: 21,
                                                   minTemp: Constants.minTemp.secondValue,
                                                   maxTemp: Constants.maxTemp.secondValue),
                                     TempRangeData(day: "Вт",
                                                   icon: sunIcon,
                                                   minDayTemp: 14,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.secondValue,
                                                   maxTemp: Constants.maxTemp.secondValue),
                                     TempRangeData(day: "Ср",
                                                   icon: sunIcon,
                                                   minDayTemp: 15,
                                                   maxDayTemp: 23,
                                                   minTemp: Constants.minTemp.secondValue,
                                                   maxTemp: Constants.maxTemp.secondValue)
                     ]),
            
            //MARK: Third City
            MOCKData(titleData: TitleData(title: Constants.title.thirdText,
                                          subtitle: Constants.subtitle.thirdText,
                                          currentTemp: Int(Constants.currentTemp.thirdValue),
                                          description: Constants.titleDescription.thirdText,
                                          minTemp: Int(Constants.currentMinTemp.thirdValue),
                                          maxTemp: Int(Constants.currentMaxTemp.thirdValue)),
                     dayTempData: (description: Constants.dayDescription.thirdText,
                                   data: [DayTempData(icon: sunIcon,
                                                      temp: 28,
                                                      time: "Сейчас"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 28,
                                                      time: "16"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 27,
                                                      time: "17"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 26,
                                                      time: "18"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 25,
                                                      time: "19"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 23,
                                                      time: "20"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 21,
                                                      time: "21"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 20,
                                                      time: "22"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 20,
                                                      time: "23"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 19,
                                                      time: "00"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 19,
                                                      time: "01"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 18,
                                                      time: "02"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 17,
                                                      time: "03")]),
                     tempRangeData: [TempRangeData(day: "Сегодня",
                                                   icon: cloudIcon,
                                                   minDayTemp: Constants.currentMinTemp.thirdValue,
                                                   maxDayTemp: Constants.currentMaxTemp.thirdValue,
                                                   minTemp: Constants.minTemp.thirdValue,
                                                   maxTemp: Constants.maxTemp.thirdValue,
                                                   currentTemp: Constants.currentTemp.thirdValue),
                                     TempRangeData(day: "Вт",
                                                   icon: cloudIcon,
                                                   minDayTemp: 17,
                                                   maxDayTemp: 25,
                                                   minTemp: Constants.minTemp.thirdValue,
                                                   maxTemp: Constants.maxTemp.thirdValue),
                                     TempRangeData(day: "Ср",
                                                   icon: sunIcon,
                                                   minDayTemp: 18,
                                                   maxDayTemp: 26,
                                                   minTemp: Constants.minTemp.thirdValue,
                                                   maxTemp: Constants.maxTemp.thirdValue),
                                     TempRangeData(day: "Чт",
                                                   icon: sunIcon,
                                                   minDayTemp: 16,
                                                   maxDayTemp: 23,
                                                   minTemp: Constants.minTemp.thirdValue,
                                                   maxTemp: Constants.maxTemp.thirdValue),
                                     TempRangeData(day: "Пт",
                                                   icon: sunIcon,
                                                   minDayTemp: 16,
                                                   maxDayTemp: 21,
                                                   minTemp: Constants.minTemp.thirdValue,
                                                   maxTemp: Constants.maxTemp.thirdValue),
                                     TempRangeData(day: "Сб",
                                                   icon: sunIcon,
                                                   minDayTemp: 16,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.thirdValue,
                                                   maxTemp: Constants.maxTemp.thirdValue),
                                     TempRangeData(day: "Вс",
                                                   icon: cloudIcon,
                                                   minDayTemp: 17,
                                                   maxDayTemp: 23,
                                                   minTemp: Constants.minTemp.thirdValue,
                                                   maxTemp: Constants.maxTemp.thirdValue),
                                     TempRangeData(day: "Пн",
                                                   icon: sunIcon,
                                                   minDayTemp: 17,
                                                   maxDayTemp: 24,
                                                   minTemp: Constants.minTemp.thirdValue,
                                                   maxTemp: Constants.maxTemp.thirdValue),
                                     TempRangeData(day: "Вт",
                                                   icon: sunIcon,
                                                   minDayTemp: 18,
                                                   maxDayTemp: 25,
                                                   minTemp: Constants.minTemp.thirdValue,
                                                   maxTemp: Constants.maxTemp.thirdValue),
                                     TempRangeData(day: "Ср",
                                                   icon: sunIcon,
                                                   minDayTemp: 19,
                                                   maxDayTemp: 27,
                                                   minTemp: Constants.minTemp.thirdValue,
                                                   maxTemp: Constants.maxTemp.thirdValue)
                     ])
        ]
    }
}
