//
//  ViewController.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/4/24.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    enum Constants: Int {
        case currentWeatherTitle
        case currenWeatherCity
        case currentWeatherDescription
        case currentTemp
        case currentMinTemp
        case currentMaxTemp
        case minTemp
        case maxTemp
        
        var text: String {
            switch self {
            case .currenWeatherCity: return "Glendale"
            case .currentWeatherTitle: return "Текущее место"
            case .currentWeatherDescription: return "Солнечно"
            default: return "No text"
            }
        }
        
        var value: Double {
            switch self {
            case .currentTemp: return 25
            case .currentMinTemp: return 16
            case .currentMaxTemp: return 25
            case .minTemp: return 13
            case .maxTemp: return 28
            default: return 0
            }
        }
    }
    
    private let backgroundImage = UIImageView()
    private let currentWeatherView = CurrentWeatherView()
    private let dayTempView = DayTempView()
    private let tempRangeView = TempRangeView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let currentHour: Int = 14
    private var hours: [String] = []
    private var hourIcon: UIImage?
    private let bottomView = BottomView()
    private let sunIcon = UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
    private let moonIcon = UIImage(systemName: "moon.stars.fill")?.withRenderingMode(.alwaysOriginal) ?? UIImage.checkmark
    private let numberOfDays = 10
    private let weekDays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    private let dayLimits: [(Min: Double, Max: Double)] = [(15, 23), (14, 23), (13, 22), (13, 20), (16, 22), (17, 24), (15, 21), (14, 19), (13, 18)]
    var days: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bottomView.listButton.addTarget(self, action: #selector(onListButtonTap), for: .touchUpInside)
        setupBackgroundImage()
        setupBottomView()
        setupScrollView()
        setupContentView()
        setupCurrentWeatherView()
        setHours()
        setDayNames(today: weekDays[0])
        setupDayTempView()
        setupTempRangeView()
    }
    
    private func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.image = UIImage(named: "sky")
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(bottomView.snp.top)
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
        currentWeatherView.setupCurrentWeather(
            CurrentWeatherView.InputData(title: Constants.currentWeatherTitle.text,
                                         subtitle: Constants.currenWeatherCity.text,
                                         currentTemp: Int(Constants.currentTemp.value),
                                         description: Constants.currentWeatherDescription.text,
                                         minTemp: Int(Constants.currentMinTemp.value),
                                         maxTemp: Int(Constants.currentMaxTemp.value))
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
            icon =  sunIcon
            return icon
        } else {
            icon = moonIcon
            return icon
        }
    }
    
    private func setHourTemp(_ hour: Int) -> Int {
        switch hour {
        case 0...7: return 16
        case 8...10: return 18
        case 11...12: return 20
        case 13...15: return 23
        case 16: return 25
        case 17: return 23
        case 18...19: return 21
        case 20...21: return 19
        case 22: return 18
        case 23: return 17
        default: break
        }
        return 0
    }
    
    private func setupDayTempView() {
        contentView.addSubview(dayTempView)
        dayTempView.setupDayTemp([DayTempView.InputData(
            icon: setHourIcon(currentHour),
            temp: Int(Constants.currentTemp.value),
            time: "Сейчас")])
        
        for (index, _) in hours.enumerated() {
            guard let hour = Int(hours[index]) else { return }
            dayTempView.setupDayTemp([DayTempView.InputData(
                icon: setHourIcon(hour),
                temp: setHourTemp(hour),
                time: hours[index])])
        }
        
        dayTempView.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
    }
    
    private func setDayNames(today: String) {
        if var index = weekDays.firstIndex(of: today) {
            for _ in 1...numberOfDays {
                if index < weekDays.count {
                    days.append(weekDays[index])
                    index += 1
                } else {
                    index = 0
                    days.append(weekDays[index])
                    index += 1
                }
            }
        }
    }
    
    private func setupTempRangeView() {
        contentView.addSubview(tempRangeView)
        for (index, _) in days.enumerated() {
            if index == 0 {
                tempRangeView.setupDayRange([TempRangeView.InputData(day: "Сегодня",
                                                                     icon: sunIcon,
                                                                     minDayTemp: Constants.currentMinTemp.value,
                                                                     maxDayTemp: Constants.currentMaxTemp.value,
                                                                     minTemp: Constants.minTemp.value,
                                                                     maxTemp: Constants.maxTemp.value,
                                                                     currentTemp: Constants.currentTemp.value)])
            } else {
                tempRangeView.setupDayRange([TempRangeView.InputData(day: days[index],
                                                                     icon: sunIcon,
                                                                     minDayTemp: dayLimits[index - 1].Min,
                                                                     maxDayTemp: dayLimits[index - 1].Max,
                                                                     minTemp: Constants.minTemp.value,
                                                                     maxTemp: Constants.maxTemp.value)])
                
                tempRangeView.snp.makeConstraints { make in
                    make.bottom.leading.equalToSuperview().inset(16)
                    make.top.equalTo(dayTempView.snp.bottom).offset(16)
                    make.width.equalTo(dayTempView)
                }
            }
        }
    }
    
    private func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(70)
        }
    }
    
    @objc private func onListButtonTap() {
        let viewController = CitySelectionViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
}
