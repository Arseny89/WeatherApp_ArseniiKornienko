//
//  CityListProvider.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/9/24.
//

import UIKit

class CityListProvider {
    var cityList: [CityData] = []
    
    enum Constants {
        case cityList
        
        var name: String {
            switch self {
            case .cityList: return "city_list"
            }
        }
    }
    
    init() {
        guard let path = Bundle.main.path(forResource: Constants.cityList.name, ofType: "json"),
              let data = try? Data(
                contentsOf: URL(fileURLWithPath: path),
                options: .mappedIfSafe
              ) else { assertionFailure("\(Constants.cityList.name).json not found")
            return
        }
        
        let decoder = JSONDecoder()
        cityList = try! decoder.decode([CityData].self, from: data)
    }
}
