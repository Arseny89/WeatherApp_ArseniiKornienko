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
    
    func viewDidLoad() {
        prepareSections()
    }
    
    private func prepareSections() {
        output?.sections = [Section.init(items: weatherData)]
    }
    
}


