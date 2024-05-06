//
//  DayTempView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/4/24.
//

import UIKit
import SnapKit

final class DayTempView: UIView {
    struct InputData {
        var icon: UIImage?
        let temp: Int
        let time: String
    }
    
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBlue.withAlphaComponent(0.5)
        layer.cornerRadius = 12
        
        setupScrollView()
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDayTemp(_ data: [InputData]) {
        data.enumerated().forEach { index, data in
            let view = HourWeatherView()
            view.setupHourWeather(data)
            stackView.addArrangedSubview(view)
            if index == 0 {
                stackView.setCustomSpacing(10, after: view)
            }
        }
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(5)
            make.verticalEdges.equalToSuperview().inset(5)
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

extension DayTempView {
    
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
        
        func setupHourWeather(_ data: InputData) {
            timeLabel.text = data.time
            icon.image = data.icon
            tempLabel.text = "\(data.temp)º"
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
