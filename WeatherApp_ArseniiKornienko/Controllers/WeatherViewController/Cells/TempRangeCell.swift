//
//  TempRangeView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/4/24.
//

import UIKit
import SnapKit

final class TempRangeCell: UITableViewCell {
    struct InputData {
        let day: String
        let icon: UIImage
        let minDayTemp: Double
        let maxDayTemp: Double
        let minTemp: Double
        let maxTemp: Double
        var currentTemp: Double? = 0
    }
    
    static let id = String(describing: TempRangeCell.self)
    private let dayView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupDayView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDayRange(_ data: TempRangeData, _ weekBarColor: UIColor) {
        dayView.subviews.forEach { $0.removeFromSuperview() }
        let view = DayRangeView()
        view.setupDayRange(data)
        let maxTempDiff = data.maxTemp - data.maxDayTemp
        let minTempDiff = data.minDayTemp - data.minTemp
        let maxOffset: Double
        let minOffset: Double
        view.weekBar.backgroundColor = weekBarColor
        maxOffset = maxTempDiff > 0 ? maxTempDiff / data.maxDayTemp : 0
        minOffset = minTempDiff > 0 ? minTempDiff / data.minDayTemp : 0
        
        view.dayBar.snp.remakeConstraints { make in
            make.trailing.equalToSuperview().multipliedBy(1 - maxOffset)
            make.width.equalToSuperview().multipliedBy(1 - minOffset - maxOffset)
            make.height.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        if let currentTemp = data.currentTemp {
            let dayTempDiff = data.maxDayTemp - data.minDayTemp
            let currentTempOffset = abs(data.minDayTemp - currentTemp) / dayTempDiff
            view.currentTempView.snp.remakeConstraints { make in
                _ = currentTempOffset == 0 || dayTempDiff == 0 ?
                make.centerX.equalTo(view.dayBar.snp.leading) :
                make.centerX.equalTo(view.dayBar.snp.trailing).multipliedBy(currentTempOffset)
                make.size.equalTo(6)
                make.centerY.equalToSuperview()
            }
        }
        
        if data.currentTemp == nil  {
            view.currentTempView.isHidden = true
        }
        
        dayView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupDayView() {
        contentView.addSubview(dayView)
        dayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension TempRangeCell {
    class DayRangeView: UIView {
        private let dayLabel = UILabel()
        private let dayIcon = UIImageView()
        private let minDayTempLabel = UILabel()
        private let maxDayTempLabel = UILabel()
        let weekBar = UIView()
        let dayBar = UIView()
        private let currentTempIcon = UIImageView()
        private let stackView = UIStackView()
        private let barsView = UIView()
        private let contentView = UIView()
        public let currentTempView = UIView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupContentView()
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
        
        func setupDayRange (_ data: TempRangeData) {
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
            weekBar.backgroundColor = .darkBlue
            weekBar.layer.cornerRadius = 2
            weekBar.snp.makeConstraints { make in
                make.height.equalTo(3)
                make.center.equalToSuperview()
                make.width.equalToSuperview()
            }
        }
        
        private func setupDayBar() {
            weekBar.addSubview(dayBar)
            dayBar.backgroundColor = .darkYellow
            dayBar.layer.borderWidth = 0.5
            dayBar.layer.borderColor = UIColor.darkBlue.withAlphaComponent(0.7).cgColor
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
        
        private func setupCurrentTempView() {
            dayBar.addSubview(currentTempView)
            
            currentTempView.backgroundColor = .white
            currentTempView.layer.borderColor = UIColor.darkBlue.withAlphaComponent(0.7).cgColor
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

