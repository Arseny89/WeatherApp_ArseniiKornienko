//
//  CitySelectionView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/7/24.
//

import UIKit
import SnapKit

final class CitySelectionViewController: UIViewController {
    
    enum Constants {
        case buttonTitleShow
        case buttonTitleHide
        
        var text: String {
            switch self {
            case .buttonTitleShow: return "Show UnitSelectionView"
            case .buttonTitleHide: return "Hide UnitSelectionView"
            }
        }
    }
    
    private let unitSelectionView = UIView()
    private let button = UIButton()
    private let cityWeatherView = CityWeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupUnitSelectionView()
        setupButton()
        setupCityWeatherView()
    }
    
    private func setupUnitSelectionView() {
        view.addSubview(unitSelectionView)
        unitSelectionView.backgroundColor = .green
        unitSelectionView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupButton() {
        view.addSubview(button)
        button.backgroundColor = .yellow
        button.setTitle(Constants.buttonTitleHide.text, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        button.snp.makeConstraints {make in
            make.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    @objc private func onClick(button: UIButton) {
        if unitSelectionView.isHidden {
            unitSelectionView.isHidden = false
            button.setTitle(Constants.buttonTitleHide.text, for: .normal)
        } else {
            unitSelectionView.isHidden = true
            button.setTitle(Constants.buttonTitleShow.text, for: .normal)
        }
    }
    
    private func setupCityWeatherView() {
        view.addSubview(cityWeatherView)
        cityWeatherView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(120)
            make.top.equalTo(button.snp.bottom).offset(15)
        }
    }
}
