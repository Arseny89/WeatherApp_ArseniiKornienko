//
//  TempRangeView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/4/24.
//

import UIKit
import SnapKit

final class TempRangeView: UIView {
    struct InputData {
        let day: String
        let icon: UIImage
        let minDayTemp: Double
        let maxDayTemp: Double
        let minTemp: Double
        let maxTemp: Double
        var currentTemp: Double? = 0
    }
    
    enum Constants {
        case title
        
        var text: String {
            switch self {
            case .title: return "Прогноз на 10 дней"
            }
        }
    }
    
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private let titleStackView = UIStackView()
    private let titleIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blueBackground.withAlphaComponent(0.5)
        layer.cornerRadius = 12
        
        setupStackView()
        setupTitleStackView()
        setupTitleIcon()
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDayRange (_ data: [InputData]) {
        data.enumerated().forEach { index, data in
            let view = DayRangeView()
            view.setupDayRange(data)
            let maxTempDiff = data.maxTemp - data.maxDayTemp
            let minTempDiff = data.minDayTemp - data.minTemp
            let maxOffset: Double
            let minOffset: Double
            
            maxOffset = maxTempDiff > 0 ? maxTempDiff / data.maxDayTemp : 0
            minOffset = minTempDiff > 0 ? minTempDiff / data.minDayTemp : 0

            view.dayBar.snp.remakeConstraints { make in
                make.trailing.equalToSuperview().multipliedBy(1 - maxOffset)
                make.width.equalToSuperview().multipliedBy(1 - minOffset - maxOffset)
                make.height.equalToSuperview()
            }
            
            if index == 0 {
                if let currentTemp = data.currentTemp {
                    let dayTempDiff = data.maxDayTemp - data.minDayTemp
                    let currentTempOffset = abs(data.minDayTemp - currentTemp) / dayTempDiff
                    view.currentTempView.snp.remakeConstraints { make in
                        _ = currentTempOffset == 0 ? 
                        make.centerX.equalTo(view.dayBar.snp.leading) :
                        make.centerX.equalTo(view.dayBar.snp.trailing).multipliedBy(currentTempOffset)
                        make.size.equalTo(6)
                        make.centerY.equalToSuperview()
                    }
                }
            } else {
                view.currentTempView.isHidden = true
            }
            stackView.addArrangedSubview(view)
        }
    }
    
    private func setupStackView() {
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTitleStackView() {
        stackView.addArrangedSubview(titleStackView)
        titleStackView.spacing = 5
        titleStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func setupTitleIcon() {
        titleStackView.addArrangedSubview(titleIcon)
        titleIcon.image = UIImage(icon: .calendar)
        titleIcon.tintColor = .white
        titleIcon.alpha = 0.8
        titleIcon.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(15)
        }
    }
    
    private func setupTitleLabel() {
        titleStackView.addArrangedSubview(titleLabel)
        titleLabel.text = Constants.title.text
        titleLabel.textColor = .white
        titleLabel.alpha = 0.8
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleIcon)
        }
    }
}

extension TempRangeView {
    final class DayRangeView: UIView {
        private let dayLabel = UILabel()
        private let dayIcon = UIImageView()
        private let minDayTempLabel = UILabel()
        private let maxDayTempLabel = UILabel()
        private let weekBar = UIView()
        let dayBar = UIView()
        private let currentTempIcon = UIImageView()
        private let stackView = UIStackView()
        private let barsView = UIView()
        private let contentView = UIView()
        private let divider = UIView()
        let currentTempView = UIView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupContentView()
            setupDivider()
            setupStackView()
            setupDayLabel()
            setupDayIcon()
            setupMinDayTempLabel()
            setupBarsView()
            setupWeekBar()
            setupMaxDayTempLabel()
            setupDayBar()
            setupCurrentTempView()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupDayRange (_ data: InputData) {
            dayLabel.text = data.day
            dayIcon.image = data.icon
            minDayTempLabel.text = "\(Int(data.minDayTemp))º"
            maxDayTempLabel.text = "\(Int(data.maxDayTemp))º"
        }
        
        private func setupContentView() {
            addSubview(contentView)
            contentView.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(16)
                make.verticalEdges.equalToSuperview()
            }
        }
        
        private func setupStackView() {
            contentView.addSubview(stackView)
            stackView.spacing = 15
            stackView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(15)
                make.bottom.equalToSuperview().inset(15)
                make.trailing.equalToSuperview()
                make.leading.equalToSuperview()
                
            }
        }
        
        private func setupDayLabel() {
            stackView.addArrangedSubview(dayLabel)
            dayLabel.textColor = .white
            dayLabel.textAlignment = .left
            dayLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            dayLabel.snp.makeConstraints { make in
                make.width.equalTo(80)
            }
        }
        
        private func setupDayIcon() {
            stackView.addArrangedSubview(dayIcon)
            dayIcon.contentMode = .scaleAspectFit
        }
        
        private func setupMinDayTempLabel() {
            stackView.addArrangedSubview(minDayTempLabel)
            minDayTempLabel.textColor = .white
            minDayTempLabel.alpha = 0.8
            minDayTempLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        }
        
        private func setupBarsView() {
            stackView.addArrangedSubview(barsView)
            barsView.snp.makeConstraints { make in
                make.height.equalToSuperview()
            }
        }
        
        private func setupWeekBar() {
            barsView.addSubview(weekBar)
            weekBar.backgroundColor = UIColor(named: "darkBlue")
            weekBar.layer.cornerRadius = 2
            weekBar.snp.makeConstraints { make in
                make.height.equalTo(3)
                make.center.equalToSuperview()
                make.width.equalToSuperview()
            }
        }
        
        private func setupDayBar() {
            weekBar.addSubview(dayBar)
            dayBar.backgroundColor = UIColor(named: "darkYellow")
            dayBar.layer.borderWidth = 0.5
            dayBar.layer.borderColor = UIColor(named: "darkBlue")?.withAlphaComponent(0.7).cgColor
            dayBar.layer.cornerRadius = 2
            dayBar.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview()
                make.leading.trailing.equalToSuperview()
            }
        }
        
        private func setupMaxDayTempLabel() {
            stackView.addArrangedSubview(maxDayTempLabel)
            maxDayTempLabel.textColor = .white
            maxDayTempLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        }
        
        private func setupDivider() {
            contentView.addSubview(divider)
            divider.backgroundColor = .white
            divider.alpha = 0.5
            divider.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.horizontalEdges.equalToSuperview()
                make.top.equalToSuperview()
            }
        }
        
        private func setupCurrentTempView() {
            dayBar.addSubview(currentTempView)
            
            currentTempView.backgroundColor = .white
            currentTempView.layer.borderColor = UIColor(named: "darkBlue")?.withAlphaComponent(1).cgColor
            currentTempView.layer.borderWidth = 1
            currentTempView.layer.cornerRadius = 3
            
            currentTempView.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.centerY.equalToSuperview()
                make.size.equalTo(6)
            }
        }
    }
}

