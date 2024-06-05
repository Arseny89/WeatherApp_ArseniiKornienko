//
//  WeatherViewModel.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/29/24.
//

import UIKit
import SnapKit


protocol WeatherViewModelInput {
    var output: WeatherViewModelOutput? { get set }
    
    func viewDidLoad()
}

protocol WeatherViewModelOutput: AnyObject {
    var dataSource: [WeatherViewModel.Section] { get set }
    
    func setupCurrentWeatherView(with data: TitleData)
    func setupBackgroundImage(with data: MOCKData?)
    func reloadData()
}

extension WeatherViewModel {
    struct Section {
        let icon: UIImage?
        let title: String?
        let items: [Item]
    }
    
    enum Item {
        case title(data: TitleCell.InputData)
        case dayTemp(data: [DayTempData])
        case tempRange(data: TempRangeData)
    }
}

final class WeatherViewModel: WeatherViewModelInput {
    
    private enum Constants {
        case dayTemp
        case tempRange
        
        
        var title: String {
            switch self {
            case .dayTemp: return "ПОЧАСОВОЙ ПРОГНОЗ"
            case .tempRange: return "ПРОГНОЗ НА 10 ДНЕЙ"
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
    
    private let weatherData: MOCKData?
    weak var output: WeatherViewModelOutput?
    
    init(with weatherData: MOCKData?) {
        self.weatherData = weatherData
    }
    
    func viewDidLoad() {
        if let weatherData {
            output?.setupCurrentWeatherView(with: weatherData.titleData)
            output?.setupBackgroundImage(with: weatherData)
            prepareDataSource(from: weatherData)
        }
    }
    
    private func prepareDataSource(from weatherData: MOCKData) {
        var forecastItems: [Item] = weatherData.tempRangeData.map { .tempRange(data: $0) }
        
        forecastItems.insert(
            .title(data: TitleCell.InputData(title: Constants.tempRange.title,
                                             icon: Constants.tempRange.icon)),
            at: 0
        )
        
        output?.dataSource = [
            Section(icon: nil,
                    title: nil,
                    items: [
                        .title(data: TitleCell.InputData(title: Constants.dayTemp.title,
                                                         icon: Constants.dayTemp.icon)),
                        .dayTemp(data: weatherData.dayTempData)
                    ]),Section(icon: nil,
                               title: nil,
                               items: forecastItems)]
    }
}

