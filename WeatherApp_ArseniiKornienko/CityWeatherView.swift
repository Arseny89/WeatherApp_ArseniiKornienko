//
//  CityWeatherView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/7/24.
//

import UIKit
import SnapKit

final class CityWeatherView: UIView {
    
    enum Constants {
        case title
        case subtitle
        case description
        case minTemp
        case maxTemp
        case currentTemp
        
        var text: String {
            switch self {
            case .title: return "Текущее место"
            case .subtitle: return "Glendale"
            case .description: return "Солнечно"
            default: return "No text"
            }
        }
        
        var value: Int {
            switch self {
            case .minTemp: return 16
            case .maxTemp: return 25
            case .currentTemp: return 25
            default: return 0
            }
        }
    }
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let tempLimitsLabel = UILabel()
    private let currentTempLabel = UILabel()
    private let backgroundImage = UIImageView()
    private let titleStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15

        setupBackgroundImage()
        setupTitleStackView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupDescriptionLabel()
        setupCurrentTempLabel()
        setupTempLimitsLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBackgroundImage() {
        addSubview(backgroundImage)

        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.cornerRadius = 15
        backgroundImage.image = UIImage(named: "sky")
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTitleStackView() {
        addSubview(titleStackView)
        titleStackView.axis = .vertical
        titleStackView.distribution = .fillProportionally
        titleStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
        }
    }
    
    private func setupTitleLabel() {
        titleStackView.addArrangedSubview(titleLabel)
        titleLabel.text = Constants.title.text
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setupSubtitleLabel() {
        titleStackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.text = Constants.subtitle.text
        subtitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        subtitleLabel.textColor = .white
        subtitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.text = Constants.description.text
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    private func setupCurrentTempLabel() {
        addSubview(currentTempLabel)
        currentTempLabel.text = "\(Constants.currentTemp.value)º"
        currentTempLabel.textColor = .white
        currentTempLabel.font = UIFont.systemFont(ofSize: 50, weight: .light)
        currentTempLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalTo(titleStackView)
        }
    }
    
    private func setupTempLimitsLabel() {
        addSubview(tempLimitsLabel)
        tempLimitsLabel.text = "Макс.:\(Constants.maxTemp.value)º, мин.:\(Constants.minTemp.value)º "
        tempLimitsLabel.textColor = .white
        tempLimitsLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        tempLimitsLabel.snp.makeConstraints { make in
            make.trailing.equalTo(currentTempLabel)
            make.centerY.equalTo(descriptionLabel)
        }
    }
}

