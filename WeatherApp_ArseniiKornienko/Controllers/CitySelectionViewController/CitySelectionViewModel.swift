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
    func getData(forced: Bool)
    func deleteCity(for id: Int)
}

protocol CitySelectionViewModelOutput: AnyObject {
    var sections: [CitySelectionViewModel.Section] { get set }
    var errorMessage: String { get set }
}

extension CitySelectionViewModel {
    struct Section: Hashable {
        var items: [CityWeatherData]
    }
}

final class CitySelectionViewModel: CitySelectionViewModelInput {
    
    weak var output: CitySelectionViewModelOutput?
    var storageManager = StorageManager()
    var selectedCityList: [CityData] {
        cityListProvider.selectedCityList
    }
    private var cityListProvider = CityListProviderImpl.shared
    private var weatherProvider: WeatherProvider?
    
    init(weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
        self.weatherProvider?.delegate = self
        getDataForCityList(for: selectedCityList, forced: false)
        cityListProvider.delegate = self
    }
    
    func getDataForCityList(for list: [CityData], forced: Bool) {
        guard !list.isEmpty else { return }
        weatherProvider?.getDataForCityList(list, forced: forced) { [weak self] data in
            guard let self else { return }
            let sortedData = selectedCityList.compactMap { data[$0.id] }
            prepareSections(with: sortedData)
        }
    }
    
    func getData(forced: Bool) {
        getDataForCityList(for: selectedCityList, forced: forced)
    }
    
    func deleteCity(for id: Int) {
        guard let cityData = selectedCityList.first(where: {$0.id == id}) else { return }
        cityListProvider.delete(cityData)
        output?.sections[0].items.removeAll(where: { $0.id == id })
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
        let sortedData = selectedCityList.compactMap { currentWeather[$0.id] }
        prepareSections(with: sortedData)
    }
}

extension CitySelectionViewModel: CityListProviderDelegate {
    func locationWasReceived() {
        getDataForCityList(for: selectedCityList, forced: true)
    }
}


