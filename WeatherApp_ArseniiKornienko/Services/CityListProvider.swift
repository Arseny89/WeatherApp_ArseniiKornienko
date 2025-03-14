//
//  CityListProvider.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/9/24.
//

import UIKit

protocol CityListProvider: AnyObject {
    var selectedCityList: [CityData] { get set }
    var delegate: CityListProviderDelegate? { get set }
    func addCity(city: CityData)
    func delete(_ city: CityData)
    func getCityList(with searchText: String?, completion: @escaping ([CityData]?) -> Void)
    
}

protocol CityListProviderDelegate: AnyObject {
    func locationWasReceived()
}

extension CityListProviderImpl {
    enum Constants: String {
        case cityList = "city_list"
    }
}

class CityListProviderImpl: CityListProvider {
    static let shared: CityListProvider = CityListProviderImpl()
    weak var delegate: CityListProviderDelegate?
    var selectedCityList: [CityData] {
        get {
            var cityList: [CityData] = StorageManager().object(for: .cityList) ?? []
            if !cityList.contains(where: { $0.id == .currentCityId}), let currentPlace {
                cityList.insert(currentPlace, at: 0)
            }
            return cityList
        }
        set {
            StorageManager().set(newValue, .cityList)
        }
    }
    var cityList: [CityData] = []
    private var currentPlace: CityData?
    private let locationProvider = LocationProvider()
    private let storageManager = StorageManager()
    private let cdStorageManager = CDStorageManager()
    
    init() {
        locationProvider.delegate = self
        if storageManager.object(for: .cityListStored) != true {
            guard let path = Bundle.main.path(forResource: Constants.cityList.rawValue, ofType: "json"),
                  let data = try? Data(
                    contentsOf: URL(fileURLWithPath: path),
                    options: .mappedIfSafe
                  ) else { assertionFailure("\(Constants.cityList.rawValue).json not found")
                return
            }
            
            let decoder = JSONDecoder()
            guard let decodedData = try?
                    decoder.decode([CityData].self, from: data) else { return }
            cityList = decodedData
            cdStorageManager.set(cityList) { [weak self] result in
                self?.storageManager.set(result, .cityListStored)
            }
        }
    }
    
    
    func addCity(city: CityData) {
        if !selectedCityList.contains(where: { $0.id == city.id }) {
            selectedCityList.append(city)
        }
        storageManager.set(selectedCityList, StorageKey.cityList)
    }
    
    func delete(_ city: CityData) {
        guard let index = selectedCityList.firstIndex(
            where: { $0.id == city.id }
        ) else {
            return
        }
        selectedCityList.remove(at: index)
    }
    
    func getCityList(with searchText: String?, completion: @escaping ([CityData]?) -> Void) {
        if let searchText {
            cdStorageManager.fetchCitySearch(with: searchText, completion: completion)
        } else {
            cdStorageManager.fetch(completion: completion)
        }
    }
}

extension CityListProviderImpl: LocationProviderDelegate {
    func setCurrentLocation(coordinates: Coordinates?) {
        guard let coordinates else { return }
        currentPlace = CityData(id: .currentCityId,
                                name: "",
                                state: "",
                                country: "",
                                coordinates: coordinates)
        delegate?.locationWasReceived()
    }
    
    func presentAlert(alert: UIAlertController) {
    }
}

extension Int {
    static let currentCityId = 0
}
