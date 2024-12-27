//
//  CurrentWeatherView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/4/24.
//

import UIKit
import SnapKit

final class CurrentWeatherView: UIView {
    struct InputData {
        let title: String
        let subtitle: String?
        let currentTemp: Int
        let description: String
        let minTemp: Int
        let maxTemp: Int
        let backgroundImage: UIImage
    }
    
    let locationNameLabel = UILabel()
    let currentTemp = UILabel()
    let isMyLocationLabel = UILabel()
    let descriptionLabel = UILabel()
    let tempLimits = UILabel()
    let hiddenLabel = UILabel()
    let topStackView = UIStackView()
    let lowerStackView  = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTopStackView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupHiddenLabel()
        setupLowerStackView()
        setupCurrentTemp()
        setupDescriptionLabel()
        setupTempLimits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCurrentWeather(_ data: CityWeatherData) {
        locationNameLabel.text = data.titleData.title
        isMyLocationLabel.text = data.titleData.subtitle?.uppercased()
        descriptionLabel.text = data.titleData.description
        guard let maxTemp = data.titleData.maxTemp?.formattedTemp(),
              let minTemp = data.titleData.minTemp?.formattedTemp(),
              let temp = data.titleData.currentTemp?.formattedTemp()
        else {
            return
        }
        hiddenLabel.text = "\(temp) | \(data.titleData.description ?? "")"
        currentTemp.text = temp
        tempLimits.text = "H.: \(maxTemp), L.: \(minTemp)"
    }
    
    private func setupTopStackView() {
        addSubview(topStackView)
        topStackView.axis = .vertical
        topStackView.distribution = .fill
        
        topStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    private func setupLowerStackView() {
        addSubview(lowerStackView)
        lowerStackView.axis = .vertical
        lowerStackView.distribution = .fill
        lowerStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(hiddenLabel)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        topStackView.addArrangedSubview(isMyLocationLabel)
        locationNameLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        locationNameLabel.textColor = .white
        locationNameLabel.textAlignment = .center
    }
    
    private func setupSubtitleLabel() {
        topStackView.addArrangedSubview(locationNameLabel)
        isMyLocationLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        isMyLocationLabel.textColor = .white
        isMyLocationLabel.textAlignment = .center
    }
    
    private func setupHiddenLabel() {
        topStackView.addArrangedSubview(hiddenLabel)
        hiddenLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        hiddenLabel.textColor = .white
        hiddenLabel.textAlignment = .center
        hiddenLabel.alpha = 0
        hiddenLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
    }
    
    private func setupCurrentTemp() {
        lowerStackView.addArrangedSubview(currentTemp)
        currentTemp.textColor = .white
        currentTemp.font = UIFont.systemFont(ofSize: 80, weight: .light)
        currentTemp.textAlignment = .center
        currentTemp.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
    }
    
    private func setupDescriptionLabel() {
        lowerStackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        descriptionLabel.textColor = .white.withAlphaComponent(0.8)
        descriptionLabel.textAlignment = .center
    }
    
    private func setupTempLimits() {
        lowerStackView.addArrangedSubview(tempLimits)
        tempLimits.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        tempLimits.textColor = .white
        tempLimits.textAlignment = .center
    }
}
