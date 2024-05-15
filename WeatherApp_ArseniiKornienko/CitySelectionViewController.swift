//
//  CitySelectionView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/7/24.
//

import UIKit
import SnapKit
import WebKit

final class CitySelectionViewController: UIViewController {
    
    enum Constants {
        case buttonTitleShow
        case buttonTitleHide
        case infoButtonTitle
        case url
        
        var text: String {
            switch self {
            case .buttonTitleShow: return "Show UnitSelectionView"
            case .buttonTitleHide: return "Hide UnitSelectionView"
            case .infoButtonTitle: return "Show info"
            case .url: return "https://www.meteoinfo.ru/t-scale"
            }
        }
    }
    
    private let unitSelectionView = UIView()
    private let switchButton = UIButton()
    private let infoButton = UIButton()
    private let cityWeatherView = CityWeatherView()
    private let scalePickerView = UIPickerView()
    private let scales: [String] = ["º C", "º F", "º K"]
    private let scalesLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupUnitSelectionView()
        setupButton()
        setupCityWeatherView()
        setupScalePickerView()
        setupScalesLabel()
        setupInfoButton()
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
        view.addSubview(switchButton)
        switchButton.backgroundColor = .yellow
        switchButton.setTitle(Constants.buttonTitleHide.text, for: .normal)
        switchButton.setTitleColor(.black, for: .normal)
        switchButton.addTarget(self, action: #selector(onSwitchButtonTap), for: .touchUpInside)
        switchButton.snp.makeConstraints {make in
            make.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func setupCityWeatherView() {
        view.addSubview(cityWeatherView)
        cityWeatherView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(120)
            make.top.equalTo(switchButton.snp.bottom).offset(15)
        }
    }
    
    private func setupScalePickerView() {
        view.addSubview(scalePickerView)
        scalePickerView.backgroundColor = .systemGray5
        scalePickerView.layer.cornerRadius = 12
        scalePickerView.dataSource = self
        scalePickerView.delegate = self
        scalePickerView.snp.makeConstraints { make in
            make.top.equalTo(cityWeatherView.snp.bottom).offset(20)
            make.centerX.equalTo(cityWeatherView)
            make.size.equalTo(80)
        }
    }
    
    private func setupScalesLabel() {
        unitSelectionView.addSubview(scalesLabel)
        scalesLabel.text = scales[0]
        scalesLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupInfoButton() {
        view.addSubview(infoButton)
        infoButton.backgroundColor = .systemGray
        infoButton.setTitle(Constants.infoButtonTitle.text, for: .normal)
        infoButton.setTitleColor(.black, for: .normal)
        infoButton.addTarget(self, action: #selector(onInfoButtonTap), for: .touchUpInside)
        infoButton.snp.makeConstraints { make in
            make.trailing.equalTo(switchButton.snp.leading).offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    @objc private func onSwitchButtonTap(button: UIButton) {
        let isSelectionHidden = unitSelectionView.isHidden
        unitSelectionView.isHidden = isSelectionHidden ? false : true
        button.setTitle(isSelectionHidden ? Constants.buttonTitleHide.text : Constants.buttonTitleShow.text, for: .normal)
    }
    
    @objc private func onInfoButtonTap(button: UIButton) {
        if let url = URL(string: Constants.url.text) {
            let webViewController = WebViewController()
            webViewController.openUrl(url)
            self.present(webViewController, animated: true)
        }
    }
}

extension CitySelectionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        scales.count
    }
    
}

extension CitySelectionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        scales[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        scalesLabel.text  = scales[row]
    }
}
