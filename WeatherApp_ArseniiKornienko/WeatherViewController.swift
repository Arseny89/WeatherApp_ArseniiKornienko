//
//  ViewController.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/4/24.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    private let currentWeatherView = CurrentWeatherView()
    private let dayTempView = DayTempView()
    private let tempRangeView = TempRangeView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let currentHour: Int = 14
    private var hours: [String] = []
    private var hourIcon: UIImage?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupScrollView()
        setupContentView()
        setupCurrentWeatherView()
        setHours()
        setupDayTempView()
        setupTempRangeView()        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "sky")?.draw(in: self.view.bounds)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        } else {
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
    
    private func setupCurrentWeatherView() {
        contentView.addSubview(currentWeatherView)
        currentWeatherView.setup(
            CurrentWeatherView.InputData(title: "Текущее место",
                                         subtitle: "Glendale",
                                         currentTemp: 25,
                                         description: "Солнечно",
                                         minTemp: 16,
                                         maxTemp: 25)
        )
        currentWeatherView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    private func setHours() {
        for i in 1...12 {
            if 1...9 ~= (currentHour + i) {
                hours.append("0\(currentHour + i)")
            } else if 24... ~= (currentHour + i) {
                switch (currentHour + i) {
                case 24...33: hours.append("0\((currentHour + i) - 24)")
                default: hours.append("\((currentHour + i) - 24)")
                }
            } else {
                hours.append("\(currentHour + i)")
            }
        }
    }
    
    private func setHourIcon(_ hour: Int) -> UIImage {
        var icon: UIImage
        if 6...20 ~= hour {
            icon =  UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
            return icon
        } else {
            icon = UIImage(systemName: "moon.stars.fill")?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
            return icon
        }
    }
    
    private func setupDayTempView() {
        contentView.addSubview(dayTempView)
        dayTempView.setup([DayTempView.InputData(icon: setHourIcon(currentHour), temp: 25, time: "Сейчас"),
                           DayTempView.InputData(icon: setHourIcon(Int(hours[0]) ?? 0), temp: 25, time: hours[0]),
                           DayTempView.InputData(icon: setHourIcon(Int(hours[1]) ?? 0), temp: 24, time: hours[1]),
                           DayTempView.InputData(icon: setHourIcon(Int(hours[2]) ?? 0), temp: 24, time: hours[2]),
                           DayTempView.InputData(icon: setHourIcon(Int(hours[3]) ?? 0), temp: 22, time: hours[3]),
                           DayTempView.InputData(icon: setHourIcon(Int(hours[4]) ?? 0), temp: 20, time: hours[4]),
                           DayTempView.InputData(icon: setHourIcon(Int(hours[5]) ?? 0), temp: 19, time: hours[5]),
                           DayTempView.InputData(icon: setHourIcon(Int(hours[6]) ?? 0), temp: 18, time: hours[6]),
                           DayTempView.InputData(icon: setHourIcon(Int(hours[7]) ?? 0), temp: 17, time: hours[7]),
                           DayTempView.InputData(icon: setHourIcon(Int(hours[8]) ?? 0), temp: 17, time: hours[8]),
                           DayTempView.InputData(icon: setHourIcon(Int(hours[9]) ?? 0), temp: 16, time: hours[9]),
                           DayTempView.InputData(icon: setHourIcon(Int(hours[10]) ?? 0), temp: 16, time: hours[10]),
                           DayTempView.InputData(icon: setHourIcon(Int(hours[11]) ?? 0), temp: 16, time: hours[11])]
        )
        
        dayTempView.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
    }
    
    private func setupTempRangeView() {
        contentView.addSubview(tempRangeView)
        tempRangeView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(dayTempView.snp.bottom).offset(16)
            make.height.equalTo(800)
        }
    }
}
