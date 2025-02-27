//
//  CityWeatherTableCell.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 1/21/25.
//

import UIKit
import SnapKit

final class CityWeatherTableCell: UITableViewCell {
    
    var tapAction: (() -> Void)?
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let tempLimitsLabel = UILabel()
    private let currentTempLabel = UILabel()
    private let backgroundImage = UIImageView()
    private let titleStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellAppearance()
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
    
    func setupCityWeather(_ data: TitleData) {
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        descriptionLabel.text = data.description
        currentTempLabel.text = data.currentTemp?.formattedTemp()
        guard let maxTemp = data.maxTemp,
              let minTemp = data.minTemp else { return }
            tempLimitsLabel.text =
            "H: \(maxTemp.formattedTemp()), L: \(minTemp.formattedTemp())"
        backgroundImage.image = data.backgroundImage
    }
    
    private func setupCellAppearance() {
        contentView.layer.backgroundColor = UIColor.black.cgColor
    }
    
    private func setupBackgroundImage() {
        addSubview(backgroundImage)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.cornerRadius = 15
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
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        titleLabel.textColor = .white
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setupSubtitleLabel() {
        titleStackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        subtitleLabel.textColor = .white
        subtitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.textColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleStackView)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setupCurrentTempLabel() {
        addSubview(currentTempLabel)
        currentTempLabel.textColor = .white
        currentTempLabel.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        currentTempLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalTo(titleStackView)
        }
    }
    
    private func setupTempLimitsLabel() {
        addSubview(tempLimitsLabel)
        tempLimitsLabel.textColor = .white
        tempLimitsLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        tempLimitsLabel.snp.makeConstraints { make in
            make.trailing.equalTo(currentTempLabel)
            make.centerY.equalTo(descriptionLabel)
        }
    }
}
