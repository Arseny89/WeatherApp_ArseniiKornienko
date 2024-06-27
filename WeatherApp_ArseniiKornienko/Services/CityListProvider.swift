//
//  CityListProvider.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/9/24.
//

import UIKit

protocol CityListProvider: AnyObject {
    var selectedCityList: [CityData] { get set }
    func addCity(city: CityData)
    func delete(_ city: CityData)
    func getCityList(with searchText: String?, completion: @escaping ([CityData]?) -> Void)
    
}

class CityListProviderImpl: CityListProvider {
    static let shared: CityListProvider = CityListProviderImpl()
    var currentCoordinates: Coordinates?
    var selectedCityList: [CityData] {
        get {
            let cityList:[CityData]? = storageManager.object(for: .cityList)
            if let currentPlace {
                return cityList ?? [currentPlace]
            } else {
                return cityList ?? []
            }
        }
        
        set {
            storageManager.set(newValue, .cityList)
        }
    }
    let locationProvider = LocationProvider()
    let currentCityId = 5352423
    var currentPlace: CityData? {
        guard let currentCoordinates else { return nil }
        return CityData(id: currentCityId,
                        name: "",
                        state: "",
                        country: "",
                        coordinates: currentCoordinates)
    }
    var cityList: [CityData] = []
    private let storageManager = StorageManager()
    private let cdStorageManager = CDStorageManager()
    
    enum Constants {
        case cityList
        
        var name: String {
            switch self {
            case .cityList: return "city_list"
            }
        }
    }
    
   private init() {
           locationProvider.delegate = self
           if storageManager.object(for: .cityListStored) != true {
               guard let path = Bundle.main.path(forResource: Constants.cityList.name, ofType: "json"),
                     let data = try? Data(
                        contentsOf: URL(fileURLWithPath: path),
                        options: .mappedIfSafe
                     ) else { assertionFailure("\(Constants.cityList.name).json not found")
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
    
    func restoreList() {
        let cityList: [CityData]? = storageManager.object(for: StorageKey.cityList)
        selectedCityList = cityList ?? []
    }
    
    func addCity(city: CityData) {
        selectedCityList.append(city)
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
        currentCoordinates = coordinates
    }
        
        func presentAlert(alert: UIAlertController) {
        }
}
