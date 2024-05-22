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
    
    private let titleLabel = UILabel()
    private let currentTemp = UILabel()
    private let subtitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let tempLimits = UILabel()
    private let stackView  = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStackView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupCurrentTemp()
        setupDescriptionLabel()
        setupTempLimits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCurrentWeather(_ data: InputData) {
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        descriptionLabel.text = data.description
        currentTemp.text = "\(data.currentTemp)º"
        tempLimits.text = "Макс.: \(data.maxTemp)º, Мин.: \(data.minTemp)º"
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 4
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
    }
    
    private func setupSubtitleLabel() {
        stackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        subtitleLabel.textColor = .white
        subtitleLabel.textAlignment = .center
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
}
