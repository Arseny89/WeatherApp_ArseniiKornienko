//
//  CitySelectionViewModel.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/3/24.
//

import UIKit
import SnapKit


protocol CitySelectionViewModelInput {
    var output: CitySelectionViewModelOutput? { get set }
    
    func viewDidLoad()
}

protocol CitySelectionViewModelOutput: AnyObject {
    var sections: [CitySelectionViewModel.Section] { get set }
}

extension CitySelectionViewModel {
    struct Section: Hashable {
        let items: [Item]
    }
}

final class CitySelectionViewModel: CitySelectionViewModelInput {
    
    typealias Item = MOCKData
    private let weatherData = MOCKData.data
    weak var output: CitySelectionViewModelOutput?
    private var weatherProvider: WeatherProvider?
    

    init(weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
        self.weatherProvider?.delegate = self
    }
    
    func viewDidLoad() {
        prepareSections(with: weatherProvider?.currentWeatherData ?? [])
    }
    
    private func prepareSections(with data: [MOCKData]) {
        output?.sections = [Section.init(items: data)]
    }
    
}

extension CitySelectionViewModel: WeatherProviderDelegate {
    func setCurrentWeather(_ currentWeather: [MOCKData]) {
        prepareSections(with: currentWeather)
    }
}


