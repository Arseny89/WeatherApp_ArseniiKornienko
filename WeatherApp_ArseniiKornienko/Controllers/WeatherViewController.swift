//
//  ViewController.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/4/24.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    struct InputData {
        let city: Int
    }
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
    private let bottomView = BottomView()
    var city: Int = 0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bottomView.listButton.addTarget(self, action: #selector(onListButtonTap), for: .touchUpInside)
        setupBackgroundImage(MOCKData.data[city])
        setupBottomView()
        setupScrollView()
        setupContentView()
        setupCurrentWeatherView(MOCKData.data[city])
        setupDayTempView(MOCKData.data[city])
        setupTempRangeView(MOCKData.data[city])
    }
    
    func setupWeatherView(_ data: InputData) {
        city = data.city
    }
    
    private func setupBackgroundImage(_ data: MOCKData?) {
        view.addSubview(backgroundImage)
        backgroundImage.contentMode = .scaleAspectFill
        if let data {
            backgroundImage.image = data.titleData.backgroundImage
        }
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
    
    private func setupCurrentWeatherView(_ data: MOCKData?) {
        contentView.addSubview(currentWeatherView)
        if let data {
            currentWeatherView.setupCurrentWeather(data.titleData)
        }
        currentWeatherView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    private func setupDayTempView(_ data: MOCKData?) {
        contentView.addSubview(dayTempView)
        if let data {
            dayTempView.setupDayTemp(data.dayTempData.data, data)
        }
        dayTempView.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func setupTempRangeView(_ data: MOCKData?) {
        contentView.addSubview(tempRangeView)
        if let data {
            tempRangeView.setupDayRange(data.tempRangeData)
        }
        tempRangeView.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview().inset(16)
            make.top.equalTo(dayTempView.snp.bottom).offset(16)
            make.width.equalTo(dayTempView)
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
        self.navigationController?.dismiss(animated: true)
    }
}
