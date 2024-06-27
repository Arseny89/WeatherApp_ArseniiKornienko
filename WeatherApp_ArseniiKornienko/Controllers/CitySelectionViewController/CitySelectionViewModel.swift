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
    func getDataForCityList(forced: Bool)
}

protocol CitySelectionViewModelOutput: AnyObject {
    var sections: [CitySelectionViewModel.Section] { get set }
    var errorMessage: String { get set }
}

extension CitySelectionViewModel {
    struct Section: Hashable {
        let items: [CityWeatherData]
    }
}

final class CitySelectionViewModel: CitySelectionViewModelInput {
    
    weak var output: CitySelectionViewModelOutput?
    var storageManager = StorageManager()
    var selectedCityList = CityListProviderImpl.shared.selectedCityList
    private var weatherProvider: WeatherProvider?
    
    init(weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
        self.weatherProvider?.delegate = self
        prepareSections(with: selectedCityList.map(\.weatherData))
        getDataForCityList(forced: false)
    }
    
    func getDataForCityList(forced: Bool) {
        weatherProvider?.getDataForCityList(selectedCityList, forced: forced) { [weak self] data in
            guard let self else { return }
            let sortedData = selectedCityList.compactMap { data[$0.id] ?? $0.weatherData }
            prepareSections(with: sortedData)
        }
    }
    
    private func prepareSections(with data: [CityWeatherData]) {
        output?.sections = [Section(items: data)]
    }
}

extension CitySelectionViewModel: WeatherProviderDelegate {
    
    func setAlertMessage(_ message: String) {
        output?.errorMessage = message
    }
    
    func setCurrentWeather(_ currentWeather: [Int: CityWeatherData]) {
        let sortedData = selectedCityList.compactMap { currentWeather[$0.id] ?? $0.weatherData }
        prepareSections(with: sortedData)
    }
}


