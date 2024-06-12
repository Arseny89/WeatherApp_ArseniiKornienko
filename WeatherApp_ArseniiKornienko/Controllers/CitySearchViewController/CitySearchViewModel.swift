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
    func getAttributedText(for indexPath: IndexPath) -> NSAttributedString?
}

protocol CitySearchViewModelOutput: AnyObject {
    var cityList: [CityData] { get set }
}

final class CitySearchViewModel: CitySearchViewModelInput {
    weak var output: CitySearchViewModelOutput?
    
    private var cityListProvider: CityListProvider
    private var searchText = ""
    
    init(cityListProvider: CityListProvider) {
        self.cityListProvider = cityListProvider
        output?.cityList = cityListProvider.cityList
    }
    
    func filterCity(with searchText: String) {
        self.searchText = searchText
        if searchText.isEmpty {
            output?.cityList = []
        } else {
            output?.cityList = cityListProvider.cityList.filter {
                $0.name.lowercased().contains(searchText)
                || $0.state.lowercased().contains(searchText)
                || $0.country.lowercased().contains(searchText)
            }
        }
    }
    
    func getAttributedText(for indexPath: IndexPath) -> NSAttributedString? {
        guard let city = output?.cityList[indexPath.row] else { return nil }
        var text = ["\(city.name)", "\(city.country)"]
        switch city.state.isEmpty {
        case false: text.insert("\(city.state)", at: 1)
        default: break
        }
        
        let attributedText = NSMutableAttributedString(
            string: text.joined(separator: ", "),
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        let textRange = (text.joined().lowercased() as NSString).range(of: searchText)
        attributedText.addAttributes([.foregroundColor: UIColor.white], range: textRange)
        
        return attributedText
    }
}
