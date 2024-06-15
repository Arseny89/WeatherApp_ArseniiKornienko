//
//  DayTempView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/4/24.
//

import UIKit
import SnapKit

final class DayTempCell: UITableViewCell {
    struct InputData {
        var icon: UIImage?
        let temp: Int
        let time: String
    }
    
    static let id = String(describing: DayTempCell.self)
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()
    private let mainView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
        setupScrollView()
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDayTemp(_ data: [DayTempData]) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        data.enumerated().forEach { index, data in
            let view = HourWeatherView()
            view.setupHourWeather(data)
            stackView.addArrangedSubview(view)
            if index == 0 {
                stackView.setCustomSpacing(10, after: view)
            }
        }
    }
    
    private func setupContentView() {
        contentView.addSubview(mainView)
        mainView.axis = .vertical
        mainView.distribution = .fillProportionally
        mainView.spacing = 10
        mainView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(5)
            make.verticalEdges.equalToSuperview().inset(5)
        }
    }
    
    private func setupScrollView() {
        mainView.addArrangedSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupStackView() {
        scrollView.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DayTempCell {
    final class HourWeatherView: UIView {
        
        private let timeLabel = UILabel()
        private let icon = UIImageView()
        private let tempLabel = UILabel()
        private let stackView = UIStackView()
        private let scrollView = UIScrollView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupStackView()
            setupTimeLabel()
            setupIcon()
            setupTemp()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupHourWeather(_ data: DayTempData) {
            timeLabel.text = data.time
            icon.image = data.icon
            tempLabel.text = data.temp?.formattedTemp()
        }
        
        private func setupTimeLabel() {
            stackView.addArrangedSubview(timeLabel)
            timeLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            timeLabel.textColor = .white
            timeLabel.textAlignment = .center
        }
        
        private func setupIcon() {
            stackView.addArrangedSubview(icon)
            icon.contentMode = .scaleAspectFit
        }
        
        private func setupTemp() {
            stackView.addArrangedSubview(tempLabel)
            tempLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            tempLabel.textColor = .white
            tempLabel.textAlignment = .center
        }
        
        private func setupStackView() {
            addSubview(stackView)
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.distribution = .fillEqually
            
            stackView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
