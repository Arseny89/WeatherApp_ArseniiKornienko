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
    
    let titleLabel = UILabel()
    let currentTemp = UILabel()
    let subtitleLabel = UILabel()
    let descriptionLabel = UILabel()
    let tempLimits = UILabel()
    let hiddenLabel = UILabel()
    private let stackView  = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupHiddenLabel()
        setupCurrentTemp()
        setupDescriptionLabel()
        setupTempLimits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCurrentWeather(_ data: CityWeatherData) {
        titleLabel.text = data.titleData.title
        subtitleLabel.text = data.titleData.subtitle
        descriptionLabel.text = data.titleData.description
        guard let maxTemp = data.titleData.maxTemp?.formattedTemp(),
              let minTemp = data.titleData.minTemp?.formattedTemp(),
              let temp = data.titleData.currentTemp?.formattedTemp()
        else {
            return
        }
        hiddenLabel.text = "\(temp) | \(data.titleData.description ?? "")"
        currentTemp.text = temp
        tempLimits.text = "Макс.: \(maxTemp), Мин.: \(minTemp)"
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        stackView.addArrangedSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
    }
    
    private func setupSubtitleLabel() {
        stackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
        subtitleLabel.snp.makeConstraints { make in
            make.height.equalTo(25)
        }
    }
    
    private func setupCurrentTemp() {
        stackView.addArrangedSubview(currentTemp)
        currentTemp.textColor = .white
        currentTemp.font = UIFont.systemFont(ofSize: 100, weight: .ultraLight)
        currentTemp.textAlignment = .center
    }
    
    private func setupDescriptionLabel() {
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
    }
    
    private func setupTempLimits() {
        stackView.addArrangedSubview(tempLimits)
        tempLimits.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        tempLimits.textColor = .white
        tempLimits.textAlignment = .center
    }
    
    private func setupHiddenLabel() {
        stackView.addArrangedSubview(hiddenLabel)
        hiddenLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        hiddenLabel.textColor = .white
        hiddenLabel.textAlignment = .center
        hiddenLabel.alpha = 0
        hiddenLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
    }
}
