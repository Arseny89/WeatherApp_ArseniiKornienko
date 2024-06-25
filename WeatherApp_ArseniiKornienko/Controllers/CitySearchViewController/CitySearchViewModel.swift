//
//  CitySearchViewModel.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/9/24.
//

import Foundation
import UIKit

protocol CitySearchViewModelInput {
    var output: CitySearchViewModelOutput? { get set }
    func filterCity(with searchText: String)
    func select(_ city: CityData)
}

protocol CitySearchViewModelOutput: AnyObject {
    var searchText: String { get set }
    var cityList: [CityData] { get set }
}

final class CitySearchViewModel: CitySearchViewModelInput {
    
    weak var output: CitySearchViewModelOutput?
    
    private var cityListProvider = CityListProviderImpl.shared
    
    init(cityListProvider: CityListProvider) {
        self.cityListProvider = cityListProvider
    }
    
    func filterCity(with searchText: String) {
        output?.searchText = searchText
        if searchText.isEmpty {
            output?.cityList = []
        } else {
            cityListProvider.getCityList(with: searchText) { [weak self] cityList in
                self?.output?.cityList = cityList ?? []
            }
        }
    }
    
    func select(_ city: CityData) {
        cityListProvider.addCity(city: city)
    }
}
