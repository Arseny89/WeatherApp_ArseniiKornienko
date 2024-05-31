//
//  MOCKDataProvider.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/19/24.
//

import UIKit

typealias TitleData = CurrentWeatherView.InputData
typealias DayTempData = DayTempCell.InputData
typealias TempRangeData = TempRangeCell.InputData

struct MOCKData {
    
   private enum Constants {
        case title
        case subtitle
        case titleDescription
        case dayDescription
        case currentTemp
        case currentMinTemp
        case currentMaxTemp
        case minTemp
        case maxTemp
        case backgroundImage
        
        var currentText: String {
            switch self {
            case .title: return "Текущее место"
            case .subtitle: return "Glendale"
            case .titleDescription: return "Солнечно"
            case .dayDescription: return "Cолнечно до конца дня. Порывы ветра до 9 ми/ч."
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
            case .subtitle: return "12:00 AM"
            case .titleDescription: return "Облачно"
            case .dayDescription: return "Облачно весь день. Порывы ветра до 12 ми/ч."
            default: return "No text"
            }
        }
        
        var secondValue: Double {
            switch self {
            case .currentTemp: return 13
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
            case .subtitle: return "3:00 PM"
            case .titleDescription: return "Солнечно"
            case .dayDescription: return "Ожидается переменная облачность около 9PM."
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
       
       var fourthText: String {
           switch self {
           case .title: return "New York"
           case .subtitle: return "5:00 PM"
           case .titleDescription: return "Преимущественно облачно"
           case .dayDescription: return "Ожидается переменная облачность около 7PM."
           default: return "No text"
           }
       }
       
       var fourthValue: Double {
           switch self {
           case .currentTemp: return 24
           case .currentMinTemp: return 17
           case .currentMaxTemp: return 27
           case .minTemp: return 12
           case .maxTemp: return 27
           default: return 0
           }
       }
       
       var fifthText: String {
           switch self {
           case .title: return "Paris"
           case .subtitle: return "11:00 PM"
           case .titleDescription: return "Преимущественно ясно"
           case .dayDescription: return "Переменная облачность с 4AM до 7AM."
           default: return "No text"
           }
       }
       
       var fifthValue: Double {
           switch self {
           case .currentTemp: return 13
           case .currentMinTemp: return 11
           case .currentMaxTemp: return 17
           case .minTemp: return 6
           case .maxTemp: return 22
           default: return 0
           }
       }
       
       var sixthText: String {
           switch self {
           case .title: return "Barcelona"
           case .subtitle: return "11:00 PM"
           case .titleDescription: return "Преимущественно облачно"
           case .dayDescription: return "Ожидается переменная облачность около 3AM."
           default: return "No text"
           }
       }
       
       var sixthValue: Double {
           switch self {
           case .currentTemp: return 18
           case .currentMinTemp: return 17
           case .currentMaxTemp: return 23
           case .minTemp: return 12
           case .maxTemp: return 26
           default: return 0
           }
       }
       
       var seventhText: String {
           switch self {
           case .title: return "Tokyo"
           case .subtitle: return "6:00 AM"
           case .titleDescription: return "Ветрено"
           case .dayDescription: return "Ожидается дождливая погода около 9AM."
           default: return "No text"
           }
       }
       
       var seventhValue: Double {
           switch self {
           case .currentTemp: return 22
           case .currentMinTemp: return 17
           case .currentMaxTemp: return 23
           case .minTemp: return 13
           case .maxTemp: return 26
           default: return 0
           }
       }
       
       var eigthText: String {
           switch self {
           case .title: return "Toronto"
           case .subtitle: return "5:00 PM"
           case .titleDescription: return "Облачно"
           case .dayDescription: return "Облачная погода до конца дня. Порывы ветра до 22 ми/ч."
           default: return "No text"
           }
       }
       
       var eigthValue: Double {
           switch self {
           case .currentTemp: return 19
           case .currentMinTemp: return 12
           case .currentMaxTemp: return 22
           case .minTemp: return 9
           case .maxTemp: return 23
           default: return 0
           }
       }
       
       var ninthText: String {
           switch self {
           case .title: return "Las Vegas"
           case .subtitle: return "2:00 PM"
           case .titleDescription: return "Солнечно"
           case .dayDescription: return "Солнечно до конца дня. Порывы ветра до 12 ми/ч."
           default: return "No text"
           }
       }
       
       var ninthValue: Double {
           switch self {
           case .currentTemp: return 33
           case .currentMinTemp: return 19
           case .currentMaxTemp: return 33
           case .minTemp: return 19
           case .maxTemp: return 39
           default: return 0
           }
       }
       
       var tenthText: String {
           switch self {
           case .title: return "Melbourne"
           case .subtitle: return "7:00 AM"
           case .titleDescription: return "Солнечно"
           case .dayDescription: return "Солнечно весь день. Порывы ветра до 10 ми/ч."
           default: return "No text"
           }
       }
       
       var tenthValue: Double {
           switch self {
           case .currentTemp: return 9
           case .currentMinTemp: return 5
           case .currentMaxTemp: return 19
           case .minTemp: return 5
           case .maxTemp: return 20
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
private let cloudSunIcon = UIImage(icon: .cloudSun)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
private let windIcon = UIImage(icon: .wind)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
private let cloudRainIcon = UIImage(icon: .cloudRain)?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark

private let sunSkyImage = UIImage(image: .sunSky) ?? UIImage.checkmark
private let cloudNightImage = UIImage(image: .cloudNight) ?? UIImage.checkmark
private let starNightImage = UIImage(image: .starNight) ?? UIImage.checkmark
private let cloudsImage = UIImage(image: .clouds) ?? UIImage.checkmark
private let cloudsGreyImage = UIImage(image: .cloudsGrey) ?? UIImage.checkmark


extension MOCKData {
    static var data: [MOCKData] {
        return [
            //MARK: Current city
            MOCKData(titleData: TitleData(title: Constants.title.currentText,
                                          subtitle: Constants.subtitle.currentText,
                                          currentTemp: Int(Constants.currentTemp.currentValue),
                                          description: Constants.titleDescription.currentText,
                                          minTemp: Int(Constants.currentMinTemp.currentValue),
                                          maxTemp: Int(Constants.currentMaxTemp.currentValue),
                                          backgroundImage: sunSkyImage),
                     dayTempData: (description: Constants.dayDescription.currentText,
                                   data: [DayTempData(icon: sunIcon,
                                                      temp: 25,
                                                      time: "Сейчас"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 25,
                                                      time: "3PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 24,
                                                      time: "4PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 24,
                                                      time: "5PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 23,
                                                      time: "6PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 21,
                                                      time: "7PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 20,
                                                      time: "8PM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 18,
                                                      time: "9PM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 16,
                                                      time: "10PM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 16,
                                                      time: "11PM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 16,
                                                      time: "12AM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 15,
                                                      time: "1AM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 15,
                                                      time: "2AM")]),
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
                                          maxTemp: Int(Constants.currentMaxTemp.secondValue),
                                          backgroundImage: cloudNightImage),
                     dayTempData: (description: Constants.dayDescription.secondText,
                                   data: [DayTempData(icon: cloudMoonIcon,
                                                      temp: 13,
                                                      time: "Сейчас"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 13,
                                                      time: "1AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 13,
                                                      time: "2AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 13,
                                                      time: "3AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 13,
                                                      time: "4AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 14,
                                                      time: "5AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 14,
                                                      time: "6AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 15,
                                                      time: "7AM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 15,
                                                      time: "8AM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 16,
                                                      time: "9AM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 17,
                                                      time: "10AM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 18,
                                                      time: "11AM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 20,
                                                      time: "12PM")]),
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
                                          maxTemp: Int(Constants.currentMaxTemp.thirdValue),
                                         backgroundImage: sunSkyImage),
                     dayTempData: (description: Constants.dayDescription.thirdText,
                                   data: [DayTempData(icon: sunIcon,
                                                      temp: 28,
                                                      time: "Сейчас"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 28,
                                                      time: "4PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 27,
                                                      time: "5PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 26,
                                                      time: "6PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 25,
                                                      time: "7PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 23,
                                                      time: "8PM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 21,
                                                      time: "9PM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 20,
                                                      time: "10PM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 20,
                                                      time: "11PM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 19,
                                                      time: "12AM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 19,
                                                      time: "1AM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 18,
                                                      time: "2AM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 17,
                                                      time: "3AM")]),
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
                     ]),
            //MARK: Fourth city
            MOCKData(titleData: TitleData(title: Constants.title.fourthText,
                                          subtitle: Constants.subtitle.fourthText,
                                          currentTemp: Int(Constants.currentTemp.fourthValue),
                                          description: Constants.titleDescription.fourthText,
                                          minTemp: Int(Constants.currentMinTemp.fourthValue),
                                          maxTemp: Int(Constants.currentMaxTemp.fourthValue),
                                          backgroundImage: cloudsImage),
                     dayTempData: (description: Constants.dayDescription.fourthText,
                                   data: [DayTempData(icon: cloudSunIcon,
                                                      temp: 24,
                                                      time: "Сейчас"),
                                          DayTempData(icon: cloudSunIcon,
                                                      temp: 22,
                                                      time: "6PM"),
                                          DayTempData(icon: cloudSunIcon,
                                                      temp: 21,
                                                      time: "7PM"),
                                          DayTempData(icon: cloudSunIcon,
                                                      temp: 21,
                                                      time: "8PM"),
                                          DayTempData(icon: cloudSunIcon,
                                                      temp: 19,
                                                      time: "9PM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 19,
                                                      time: "10PM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 18,
                                                      time: "11PM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 17,
                                                      time: "12AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 17,
                                                      time: "1AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 17,
                                                      time: "2AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 16,
                                                      time: "3AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 17,
                                                      time: "4AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 17,
                                                      time: "5AM")]),
                     tempRangeData: [TempRangeData(day: "Сегодня",
                                                   icon: cloudIcon,
                                                   minDayTemp: Constants.currentMinTemp.fourthValue,
                                                   maxDayTemp: Constants.currentMaxTemp.fourthValue,
                                                   minTemp: Constants.minTemp.fourthValue,
                                                   maxTemp: Constants.maxTemp.fourthValue,
                                                   currentTemp: Constants.currentTemp.fourthValue),
                                     TempRangeData(day: "Вт",
                                                   icon: cloudIcon,
                                                   minDayTemp: 16,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.fourthValue,
                                                   maxTemp: Constants.maxTemp.fourthValue),
                                     TempRangeData(day: "Ср",
                                                   icon: cloudSunIcon,
                                                   minDayTemp: 19,
                                                   maxDayTemp: 27,
                                                   minTemp: Constants.minTemp.fourthValue,
                                                   maxTemp: Constants.maxTemp.fourthValue),
                                     TempRangeData(day: "Чт",
                                                   icon: cloudSunIcon,
                                                   minDayTemp: 16,
                                                   maxDayTemp: 24,
                                                   minTemp: Constants.minTemp.fourthValue,
                                                   maxTemp: Constants.maxTemp.fourthValue),
                                     TempRangeData(day: "Пт",
                                                   icon: sunIcon,
                                                   minDayTemp: 14,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.fourthValue,
                                                   maxTemp: Constants.maxTemp.fourthValue),
                                     TempRangeData(day: "Сб",
                                                   icon: sunIcon,
                                                   minDayTemp: 12,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.fourthValue,
                                                   maxTemp: Constants.maxTemp.fourthValue),
                                     TempRangeData(day: "Вс",
                                                   icon: cloudSunIcon,
                                                   minDayTemp: 13,
                                                   maxDayTemp: 24,
                                                   minTemp: Constants.minTemp.fourthValue,
                                                   maxTemp: Constants.maxTemp.fourthValue),
                                     TempRangeData(day: "Пн",
                                                   icon: sunIcon,
                                                   minDayTemp: 14,
                                                   maxDayTemp: 23,
                                                   minTemp: Constants.minTemp.fourthValue,
                                                   maxTemp: Constants.maxTemp.fourthValue),
                                     TempRangeData(day: "Вт",
                                                   icon: cloudSunIcon,
                                                   minDayTemp: 13,
                                                   maxDayTemp: 25,
                                                   minTemp: Constants.minTemp.fourthValue,
                                                   maxTemp: Constants.maxTemp.fourthValue),
                                     TempRangeData(day: "Ср",
                                                   icon: cloudSunIcon,
                                                   minDayTemp: 14,
                                                   maxDayTemp: 23,
                                                   minTemp: Constants.minTemp.fourthValue,
                                                   maxTemp: Constants.maxTemp.fourthValue)
                     ]),
            //MARK: Fifth city
            MOCKData(titleData: TitleData(title: Constants.title.fifthText,
                                          subtitle: Constants.subtitle.fifthText,
                                          currentTemp: Int(Constants.currentTemp.fifthValue),
                                          description: Constants.titleDescription.fifthText,
                                          minTemp: Int(Constants.currentMinTemp.fifthValue),
                                          maxTemp: Int(Constants.currentMaxTemp.fifthValue),
                                          backgroundImage: starNightImage),
                     dayTempData: (description: Constants.dayDescription.fifthText,
                                   data: [DayTempData(icon: moonIcon,
                                                      temp: 13,
                                                      time: "Сейчас"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 13,
                                                      time: "12AM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 13,
                                                      time: "1AM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 13,
                                                      time: "2AM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 12,
                                                      time: "3AM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 11,
                                                      time: "4AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 11,
                                                      time: "5AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 11,
                                                      time: "6AM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 12,
                                                      time: "7AM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 12,
                                                      time: "8AM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 13,
                                                      time: "9AM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 14,
                                                      time: "10AM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 20,
                                                      time: "11AM")]),
                     tempRangeData: [TempRangeData(day: "Сегодня",
                                                   icon: cloudIcon,
                                                   minDayTemp: Constants.currentMinTemp.fifthValue,
                                                   maxDayTemp: Constants.currentMaxTemp.fifthValue,
                                                   minTemp: Constants.minTemp.fifthValue,
                                                   maxTemp: Constants.maxTemp.fifthValue,
                                                   currentTemp: Constants.currentTemp.fifthValue),
                                     TempRangeData(day: "Вт",
                                                   icon: cloudIcon,
                                                   minDayTemp: 9,
                                                   maxDayTemp: 18,
                                                   minTemp: Constants.minTemp.fifthValue,
                                                   maxTemp: Constants.maxTemp.fifthValue),
                                     TempRangeData(day: "Ср",
                                                   icon: cloudIcon,
                                                   minDayTemp: 12,
                                                   maxDayTemp: 20,
                                                   minTemp: Constants.minTemp.fifthValue,
                                                   maxTemp: Constants.maxTemp.fifthValue),
                                     TempRangeData(day: "Чт",
                                                   icon: cloudIcon,
                                                   minDayTemp: 10,
                                                   maxDayTemp: 19,
                                                   minTemp: Constants.minTemp.fifthValue,
                                                   maxTemp: Constants.maxTemp.fifthValue),
                                     TempRangeData(day: "Пт",
                                                   icon: cloudSunIcon,
                                                   minDayTemp: 10,
                                                   maxDayTemp: 17,
                                                   minTemp: Constants.minTemp.fifthValue,
                                                   maxTemp: Constants.maxTemp.fifthValue),
                                     TempRangeData(day: "Сб",
                                                   icon: cloudSunIcon,
                                                   minDayTemp: 10,
                                                   maxDayTemp: 19,
                                                   minTemp: Constants.minTemp.fifthValue,
                                                   maxTemp: Constants.maxTemp.fifthValue),
                                     TempRangeData(day: "Вс",
                                                   icon: cloudIcon,
                                                   minDayTemp: 8,
                                                   maxDayTemp: 19,
                                                   minTemp: Constants.minTemp.fifthValue,
                                                   maxTemp: Constants.maxTemp.fifthValue),
                                     TempRangeData(day: "Пн",
                                                   icon: cloudIcon,
                                                   minDayTemp: 8,
                                                   maxDayTemp: 20,
                                                   minTemp: Constants.minTemp.fifthValue,
                                                   maxTemp: Constants.maxTemp.fifthValue),
                                     TempRangeData(day: "Вт",
                                                   icon: cloudSunIcon,
                                                   minDayTemp: 6,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.fifthValue,
                                                   maxTemp: Constants.maxTemp.fifthValue),
                                     TempRangeData(day: "Ср",
                                                   icon: cloudSunIcon,
                                                   minDayTemp: 8,
                                                   maxDayTemp: 21,
                                                   minTemp: Constants.minTemp.fifthValue,
                                                   maxTemp: Constants.maxTemp.fifthValue)
                     ]),
            //MARK: Sixth city
            MOCKData(titleData: TitleData(title: Constants.title.sixthText,
                                          subtitle: Constants.subtitle.sixthText,
                                          currentTemp: Int(Constants.currentTemp.sixthValue),
                                          description: Constants.titleDescription.sixthText,
                                          minTemp: Int(Constants.currentMinTemp.sixthValue),
                                          maxTemp: Int(Constants.currentMaxTemp.sixthValue),
                                          backgroundImage: cloudNightImage),
                     dayTempData: (description: Constants.dayDescription.sixthText,
                                   data: [DayTempData(icon: cloudMoonIcon,
                                                      temp: 18,
                                                      time: "Сейчас"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 18,
                                                      time: "12AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 18,
                                                      time: "1AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 18,
                                                      time: "2AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 17,
                                                      time: "3AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 17,
                                                      time: "4AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 17,
                                                      time: "5AM"),
                                          DayTempData(icon: cloudMoonIcon,
                                                      temp: 17,
                                                      time: "6AM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 17,
                                                      time: "7AM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 18,
                                                      time: "8AM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 19,
                                                      time: "9AM"),
                                          DayTempData(icon: cloudSunIcon,
                                                      temp: 20,
                                                      time: "10AM"),
                                          DayTempData(icon: cloudSunIcon,
                                                      temp: 21,
                                                      time: "11AM")]),
                     tempRangeData: [TempRangeData(day: "Сегодня",
                                                   icon: cloudIcon,
                                                   minDayTemp: Constants.currentMinTemp.sixthValue,
                                                   maxDayTemp: Constants.currentMaxTemp.sixthValue,
                                                   minTemp: Constants.minTemp.sixthValue,
                                                   maxTemp: Constants.maxTemp.sixthValue,
                                                   currentTemp: Constants.currentTemp.sixthValue),
                                     TempRangeData(day: "Ср",
                                                   icon: sunIcon,
                                                   minDayTemp: 16,
                                                   maxDayTemp: 24,
                                                   minTemp: Constants.minTemp.sixthValue,
                                                   maxTemp: Constants.maxTemp.sixthValue),
                                     TempRangeData(day: "Чт",
                                                   icon: cloudSunIcon,
                                                   minDayTemp: 16,
                                                   maxDayTemp: 25,
                                                   minTemp: Constants.minTemp.sixthValue,
                                                   maxTemp: Constants.maxTemp.sixthValue),
                                     TempRangeData(day: "Пт",
                                                   icon: sunIcon,
                                                   minDayTemp: 17,
                                                   maxDayTemp: 23,
                                                   minTemp: Constants.minTemp.sixthValue,
                                                   maxTemp: Constants.maxTemp.sixthValue),
                                     TempRangeData(day: "Сб",
                                                   icon: cloudIcon,
                                                   minDayTemp: 16,
                                                   maxDayTemp: 21,
                                                   minTemp: Constants.minTemp.sixthValue,
                                                   maxTemp: Constants.maxTemp.sixthValue),
                                     TempRangeData(day: "Вс",
                                                   icon: cloudIcon,
                                                   minDayTemp: 15,
                                                   maxDayTemp: 21,
                                                   minTemp: Constants.minTemp.sixthValue,
                                                   maxTemp: Constants.maxTemp.sixthValue),
                                     TempRangeData(day: "Пн",
                                                   icon: cloudSunIcon,
                                                   minDayTemp: 14,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.sixthValue,
                                                   maxTemp: Constants.maxTemp.sixthValue),
                                     TempRangeData(day: "Вт",
                                                   icon: sunIcon,
                                                   minDayTemp: 12,
                                                   maxDayTemp: 23,
                                                   minTemp: Constants.minTemp.sixthValue,
                                                   maxTemp: Constants.maxTemp.sixthValue),
                                     TempRangeData(day: "Ср",
                                                   icon: sunIcon,
                                                   minDayTemp: 13,
                                                   maxDayTemp: 23,
                                                   minTemp: Constants.minTemp.sixthValue,
                                                   maxTemp: Constants.maxTemp.sixthValue),
                                     TempRangeData(day: "Чт",
                                                   icon: sunIcon,
                                                   minDayTemp: 13,
                                                   maxDayTemp: 26,
                                                   minTemp: Constants.minTemp.sixthValue,
                                                   maxTemp: Constants.maxTemp.sixthValue)
                     ]),
            //MARK: Seventh city
            MOCKData(titleData: TitleData(title: Constants.title.seventhText,
                                          subtitle: Constants.subtitle.seventhText,
                                          currentTemp: Int(Constants.currentTemp.seventhValue),
                                          description: Constants.titleDescription.seventhText,
                                          minTemp: Int(Constants.currentMinTemp.seventhValue),
                                          maxTemp: Int(Constants.currentMaxTemp.seventhValue),
                                          backgroundImage: cloudsGreyImage),
                     dayTempData: (description: Constants.dayDescription.seventhText,
                                   data: [DayTempData(icon: windIcon,
                                                      temp: 22,
                                                      time: "Сейчас"),
                                          DayTempData(icon: windIcon,
                                                      temp: 22,
                                                      time: "7AM"),
                                          DayTempData(icon: windIcon,
                                                      temp: 22,
                                                      time: "8AM"),
                                          DayTempData(icon: windIcon,
                                                      temp: 23,
                                                      time: "9AM"),
                                          DayTempData(icon: cloudRainIcon,
                                                      temp: 23,
                                                      time: "10AM"),
                                          DayTempData(icon: cloudRainIcon,
                                                      temp: 14,
                                                      time: "11AM"),
                                          DayTempData(icon: cloudRainIcon,
                                                      temp: 14,
                                                      time: "12PM"),
                                          DayTempData(icon: cloudRainIcon,
                                                      temp: 15,
                                                      time: "1PM"),
                                          DayTempData(icon: cloudRainIcon,
                                                      temp: 15,
                                                      time: "2PM"),
                                          DayTempData(icon: cloudRainIcon,
                                                      temp: 16,
                                                      time: "3PM"),
                                          DayTempData(icon: windIcon,
                                                      temp: 17,
                                                      time: "4PM"),
                                          DayTempData(icon: windIcon,
                                                      temp: 18,
                                                      time: "5PM"),
                                          DayTempData(icon: windIcon,
                                                      temp: 20,
                                                      time: "6PM")]),
                     tempRangeData: [TempRangeData(day: "Сегодня",
                                                   icon: cloudIcon,
                                                   minDayTemp: Constants.currentMinTemp.seventhValue,
                                                   maxDayTemp: Constants.currentMaxTemp.seventhValue,
                                                   minTemp: Constants.minTemp.seventhValue,
                                                   maxTemp: Constants.maxTemp.seventhValue,
                                                   currentTemp: Constants.currentTemp.seventhValue),
                                     TempRangeData(day: "Вт",
                                                   icon: cloudIcon,
                                                   minDayTemp: 21,
                                                   maxDayTemp: 25,
                                                   minTemp: Constants.minTemp.seventhValue,
                                                   maxTemp: Constants.maxTemp.seventhValue),
                                     TempRangeData(day: "Ср",
                                                   icon: sunIcon,
                                                   minDayTemp: 18,
                                                   maxDayTemp: 25,
                                                   minTemp: Constants.minTemp.seventhValue,
                                                   maxTemp: Constants.maxTemp.seventhValue),
                                     TempRangeData(day: "Чт",
                                                   icon: sunIcon,
                                                   minDayTemp: 17,
                                                   maxDayTemp: 27,
                                                   minTemp: Constants.minTemp.seventhValue,
                                                   maxTemp: Constants.maxTemp.seventhValue),
                                     TempRangeData(day: "Пт",
                                                   icon: sunIcon,
                                                   minDayTemp: 15,
                                                   maxDayTemp: 19,
                                                   minTemp: Constants.minTemp.seventhValue,
                                                   maxTemp: Constants.maxTemp.seventhValue),
                                     TempRangeData(day: "Сб",
                                                   icon: sunIcon,
                                                   minDayTemp: 15,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.seventhValue,
                                                   maxTemp: Constants.maxTemp.seventhValue),
                                     TempRangeData(day: "Вс",
                                                   icon: cloudIcon,
                                                   minDayTemp: 13,
                                                   maxDayTemp: 20,
                                                   minTemp: Constants.minTemp.seventhValue,
                                                   maxTemp: Constants.maxTemp.seventhValue),
                                     TempRangeData(day: "Пн",
                                                   icon: sunIcon,
                                                   minDayTemp: 12,
                                                   maxDayTemp: 21,
                                                   minTemp: Constants.minTemp.seventhValue,
                                                   maxTemp: Constants.maxTemp.seventhValue),
                                     TempRangeData(day: "Вт",
                                                   icon: sunIcon,
                                                   minDayTemp: 13,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.seventhValue,
                                                   maxTemp: Constants.maxTemp.seventhValue),
                                     TempRangeData(day: "Ср",
                                                   icon: sunIcon,
                                                   minDayTemp: 13,
                                                   maxDayTemp: 23,
                                                   minTemp: Constants.minTemp.seventhValue,
                                                   maxTemp: Constants.maxTemp.seventhValue)
                     ]),
            //MARK: Eigth city
            MOCKData(titleData: TitleData(title: Constants.title.eigthText,
                                          subtitle: Constants.subtitle.eigthText,
                                          currentTemp: Int(Constants.currentTemp.eigthValue),
                                          description: Constants.titleDescription.eigthText,
                                          minTemp: Int(Constants.currentMinTemp.eigthValue),
                                          maxTemp: Int(Constants.currentMaxTemp.eigthValue),
                                          backgroundImage: cloudNightImage),
                     dayTempData: (description: Constants.dayDescription.eigthText,
                                   data: [DayTempData(icon: cloudMoonIcon,
                                                      temp: 19,
                                                      time: "Сейчас"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 18,
                                                      time: "6PM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 18,
                                                      time: "7PM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 18,
                                                      time: "8PM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 18,
                                                      time: "9PM"),
                                          DayTempData(icon: cloudIcon,
                                                      temp: 17,
                                                      time: "10PM"),
                                          DayTempData(icon: windIcon,
                                                      temp: 17,
                                                      time: "11PM"),
                                          DayTempData(icon: cloudRainIcon,
                                                      temp: 15,
                                                      time: "12AM"),
                                          DayTempData(icon: cloudRainIcon,
                                                      temp: 15,
                                                      time: "1AM"),
                                          DayTempData(icon: cloudRainIcon,
                                                      temp: 16,
                                                      time: "2AM"),
                                          DayTempData(icon: cloudRainIcon,
                                                      temp: 17,
                                                      time: "3AM"),
                                          DayTempData(icon: cloudRainIcon,
                                                      temp: 18,
                                                      time: "4AM"),
                                          DayTempData(icon: cloudRainIcon,
                                                      temp: 20,
                                                      time: "5AM")]),
                     tempRangeData: [TempRangeData(day: "Сегодня",
                                                   icon: cloudRainIcon,
                                                   minDayTemp: Constants.currentMinTemp.eigthValue,
                                                   maxDayTemp: Constants.currentMaxTemp.eigthValue,
                                                   minTemp: Constants.minTemp.eigthValue,
                                                   maxTemp: Constants.maxTemp.eigthValue,
                                                   currentTemp: Constants.currentTemp.eigthValue),
                                     TempRangeData(day: "Вт",
                                                   icon: cloudRainIcon,
                                                   minDayTemp: 15,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.eigthValue,
                                                   maxTemp: Constants.maxTemp.eigthValue),
                                     TempRangeData(day: "Ср",
                                                   icon: cloudRainIcon,
                                                   minDayTemp: 14,
                                                   maxDayTemp: 20,
                                                   minTemp: Constants.minTemp.eigthValue,
                                                   maxTemp: Constants.maxTemp.eigthValue),
                                     TempRangeData(day: "Чт",
                                                   icon: cloudIcon,
                                                   minDayTemp: 11,
                                                   maxDayTemp: 18,
                                                   minTemp: Constants.minTemp.eigthValue,
                                                   maxTemp: Constants.maxTemp.eigthValue),
                                     TempRangeData(day: "Пт",
                                                   icon: sunIcon,
                                                   minDayTemp: 9,
                                                   maxDayTemp: 18,
                                                   minTemp: Constants.minTemp.eigthValue,
                                                   maxTemp: Constants.maxTemp.eigthValue),
                                     TempRangeData(day: "Сб",
                                                   icon: sunIcon,
                                                   minDayTemp: 10,
                                                   maxDayTemp: 21,
                                                   minTemp: Constants.minTemp.eigthValue,
                                                   maxTemp: Constants.maxTemp.eigthValue),
                                     TempRangeData(day: "Вс",
                                                   icon: cloudIcon,
                                                   minDayTemp: 11,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.eigthValue,
                                                   maxTemp: Constants.maxTemp.eigthValue),
                                     TempRangeData(day: "Пн",
                                                   icon: sunIcon,
                                                   minDayTemp: 13,
                                                   maxDayTemp: 23,
                                                   minTemp: Constants.minTemp.eigthValue,
                                                   maxTemp: Constants.maxTemp.eigthValue),
                                     TempRangeData(day: "Вт",
                                                   icon: cloudIcon,
                                                   minDayTemp: 11,
                                                   maxDayTemp: 22,
                                                   minTemp: Constants.minTemp.eigthValue,
                                                   maxTemp: Constants.maxTemp.eigthValue),
                                     TempRangeData(day: "Ср",
                                                   icon: cloudIcon,
                                                   minDayTemp: 10,
                                                   maxDayTemp: 20,
                                                   minTemp: Constants.minTemp.eigthValue,
                                                   maxTemp: Constants.maxTemp.eigthValue)
                     ]),
            //MARK: Ninth city
            MOCKData(titleData: TitleData(title: Constants.title.ninthText,
                                          subtitle: Constants.subtitle.ninthText,
                                          currentTemp: Int(Constants.currentTemp.ninthValue),
                                          description: Constants.titleDescription.ninthText,
                                          minTemp: Int(Constants.currentMinTemp.ninthValue),
                                          maxTemp: Int(Constants.currentMaxTemp.ninthValue),
                                          backgroundImage: sunSkyImage),
                     dayTempData: (description: Constants.dayDescription.ninthText,
                                   data: [DayTempData(icon: sunIcon,
                                                      temp: 33,
                                                      time: "Сейчас"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 33,
                                                      time: "3PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 33,
                                                      time: "4PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 33,
                                                      time: "5PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 33,
                                                      time: "6PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 32,
                                                      time: "7PM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 29,
                                                      time: "8PM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 28,
                                                      time: "9PM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 26,
                                                      time: "10PM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 24,
                                                      time: "11PM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 23,
                                                      time: "12AM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 22,
                                                      time: "1AM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 21,
                                                      time: "2AM")]),
                     tempRangeData: [TempRangeData(day: "Сегодня",
                                                   icon: sunIcon,
                                                   minDayTemp: Constants.currentMinTemp.ninthValue,
                                                   maxDayTemp: Constants.currentMaxTemp.ninthValue,
                                                   minTemp: Constants.minTemp.ninthValue,
                                                   maxTemp: Constants.maxTemp.ninthValue,
                                                   currentTemp: Constants.currentTemp.ninthValue),
                                     TempRangeData(day: "Вт",
                                                   icon: sunIcon,
                                                   minDayTemp: 18,
                                                   maxDayTemp: 35,
                                                   minTemp: Constants.minTemp.ninthValue,
                                                   maxTemp: Constants.maxTemp.ninthValue),
                                     TempRangeData(day: "Ср",
                                                   icon: sunIcon,
                                                   minDayTemp: 20,
                                                   maxDayTemp: 37,
                                                   minTemp: Constants.minTemp.ninthValue,
                                                   maxTemp: Constants.maxTemp.ninthValue),
                                     TempRangeData(day: "Чт",
                                                   icon: sunIcon,
                                                   minDayTemp: 20,
                                                   maxDayTemp: 37,
                                                   minTemp: Constants.minTemp.ninthValue,
                                                   maxTemp: Constants.maxTemp.ninthValue),
                                     TempRangeData(day: "Пт",
                                                   icon: sunIcon,
                                                   minDayTemp: 22,
                                                   maxDayTemp: 38,
                                                   minTemp: Constants.minTemp.ninthValue,
                                                   maxTemp: Constants.maxTemp.ninthValue),
                                     TempRangeData(day: "Сб",
                                                   icon: sunIcon,
                                                   minDayTemp: 22,
                                                   maxDayTemp: 39,
                                                   minTemp: Constants.minTemp.ninthValue,
                                                   maxTemp: Constants.maxTemp.ninthValue),
                                     TempRangeData(day: "Вс",
                                                   icon: sunIcon,
                                                   minDayTemp: 21,
                                                   maxDayTemp: 38,
                                                   minTemp: Constants.minTemp.ninthValue,
                                                   maxTemp: Constants.maxTemp.ninthValue),
                                     TempRangeData(day: "Пн",
                                                   icon: sunIcon,
                                                   minDayTemp: 21,
                                                   maxDayTemp: 38,
                                                   minTemp: Constants.minTemp.ninthValue,
                                                   maxTemp: Constants.maxTemp.ninthValue),
                                     TempRangeData(day: "Вт",
                                                   icon: sunIcon,
                                                   minDayTemp: 22,
                                                   maxDayTemp: 39,
                                                   minTemp: Constants.minTemp.ninthValue,
                                                   maxTemp: Constants.maxTemp.ninthValue),
                                     TempRangeData(day: "Ср",
                                                   icon: sunIcon,
                                                   minDayTemp: 21,
                                                   maxDayTemp: 38,
                                                   minTemp: Constants.minTemp.ninthValue,
                                                   maxTemp: Constants.maxTemp.ninthValue)
                     ]),
            //MARK: Tenth city
            MOCKData(titleData: TitleData(title: Constants.title.tenthText,
                                          subtitle: Constants.subtitle.tenthText,
                                          currentTemp: Int(Constants.currentTemp.tenthValue),
                                          description: Constants.titleDescription.tenthText,
                                          minTemp: Int(Constants.currentMinTemp.tenthValue),
                                          maxTemp: Int(Constants.currentMaxTemp.tenthValue),
                                          backgroundImage: sunSkyImage),
                     dayTempData: (description: Constants.dayDescription.secondText,
                                   data: [DayTempData(icon: sunIcon,
                                                      temp: 9,
                                                      time: "Сейчас"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 10,
                                                      time: "8AM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 11,
                                                      time: "9AM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 12,
                                                      time: "10AM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 14,
                                                      time: "11AM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 16,
                                                      time: "12PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 18,
                                                      time: "1PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 19,
                                                      time: "2PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 19,
                                                      time: "3PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 19,
                                                      time: "4PM"),
                                          DayTempData(icon: sunIcon,
                                                      temp: 17,
                                                      time: "5PM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 16,
                                                      time: "6PM"),
                                          DayTempData(icon: moonIcon,
                                                      temp: 14,
                                                      time: "7PM")]),
                     tempRangeData: [TempRangeData(day: "Сегодня",
                                                   icon: sunIcon,
                                                   minDayTemp: Constants.currentMinTemp.tenthValue,
                                                   maxDayTemp: Constants.currentMaxTemp.tenthValue,
                                                   minTemp: Constants.minTemp.tenthValue,
                                                   maxTemp: Constants.maxTemp.tenthValue,
                                                   currentTemp: Constants.currentTemp.tenthValue),
                                     TempRangeData(day: "Ср",
                                                   icon: sunIcon,
                                                   minDayTemp: 9,
                                                   maxDayTemp: 20,
                                                   minTemp: Constants.minTemp.tenthValue,
                                                   maxTemp: Constants.maxTemp.tenthValue),
                                     TempRangeData(day: "Чт",
                                                   icon: sunIcon,
                                                   minDayTemp: 9,
                                                   maxDayTemp: 19,
                                                   minTemp: Constants.minTemp.tenthValue,
                                                   maxTemp: Constants.maxTemp.tenthValue),
                                     TempRangeData(day: "Пт",
                                                   icon: windIcon,
                                                   minDayTemp: 13,
                                                   maxDayTemp: 21,
                                                   minTemp: Constants.minTemp.tenthValue,
                                                   maxTemp: Constants.maxTemp.tenthValue),
                                     TempRangeData(day: "Сб",
                                                   icon: sunIcon,
                                                   minDayTemp: 10,
                                                   maxDayTemp: 16,
                                                   minTemp: Constants.minTemp.tenthValue,
                                                   maxTemp: Constants.maxTemp.tenthValue),
                                     TempRangeData(day: "Вс",
                                                   icon: cloudRainIcon,
                                                   minDayTemp: 7,
                                                   maxDayTemp: 13,
                                                   minTemp: Constants.minTemp.tenthValue,
                                                   maxTemp: Constants.maxTemp.tenthValue),
                                     TempRangeData(day: "Пн",
                                                   icon: cloudSunIcon,
                                                   minDayTemp: 6,
                                                   maxDayTemp: 15,
                                                   minTemp: Constants.minTemp.tenthValue,
                                                   maxTemp: Constants.maxTemp.tenthValue),
                                     TempRangeData(day: "Вт",
                                                   icon: cloudSunIcon,
                                                   minDayTemp: 7,
                                                   maxDayTemp: 15,
                                                   minTemp: Constants.minTemp.tenthValue,
                                                   maxTemp: Constants.maxTemp.tenthValue),
                                     TempRangeData(day: "Ср",
                                                   icon: cloudIcon,
                                                   minDayTemp: 7,
                                                   maxDayTemp: 14,
                                                   minTemp: Constants.minTemp.tenthValue,
                                                   maxTemp: Constants.maxTemp.tenthValue),
                                     TempRangeData(day: "Чт",
                                                   icon: cloudRainIcon,
                                                   minDayTemp: 10,
                                                   maxDayTemp: 17,
                                                   minTemp: Constants.minTemp.tenthValue,
                                                   maxTemp: Constants.maxTemp.tenthValue)
                     ]),
        ]
    }
}
