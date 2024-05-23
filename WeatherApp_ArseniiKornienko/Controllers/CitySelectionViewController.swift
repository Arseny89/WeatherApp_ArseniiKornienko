//
//  CitySelectionView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/7/24.
//

import UIKit
import SnapKit
import WebKit

final class CitySelectionViewController: UIViewController {
    
    enum Constants {
        case infoButtonTitle
        case url
        case title
        
        var text: String {
            switch self {
            case .infoButtonTitle: return "Show info"
            case .url: return "https://www.meteoinfo.ru/t-scale"
            case .title: return "Погода"
            }
        }
    }
    
    private let unitSelectionView = UIView()
    private let infoButton = UIButton()
    private let contentView = UIView()
    private let cityWeatherView = CityWeatherView()
    private let scalePickerView = UIPickerView()
    private let weatherView = WeatherViewController()
    private let scales: [String] = ["º C", "º F", "º K"]
    private var pickedScale: String = ""
    private let cityStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = Constants.title.text
        
        setupNavigationBar()
        setupContentView()
        setupCityStackView()
        setupUnitSelectionView()
        setupScalePickerView()
        setupInfoButton()
        presentCityWeater(withCityIndex: 0)
    }
    
    private func setupUnitSelectionView() {
        contentView.addSubview(unitSelectionView)
        unitSelectionView.backgroundColor = .green
        unitSelectionView.delegate = self
        unitSelectionView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(cityStackView.snp.bottom).offset(15)
        }
    }
    
    private func onInfoButtonTap() {
        guard let url = URL(string: Constants.url.text) else { return }
        let webViewController = WebViewController()
        let viewController = UINavigationController(rootViewController: webViewController)
        webViewController.openUrl(url)
        self.present(viewController, animated: true)
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupCityStackView() {
        contentView.addSubview(cityStackView)
        cityStackView.axis = .vertical
        cityStackView.spacing = 15
        cityStackView.distribution = .fillEqually
        
        MOCKData.data.enumerated().forEach { index, data in
            let cityWeatherView = CityWeatherView()
            cityWeatherView.setupCityWeather(CurrentWeatherView.InputData(title: data.titleData.title,
                                                                          subtitle: data.titleData.subtitle,
                                                                          currentTemp: data.titleData.currentTemp,
                                                                          description: data.titleData.description,
                                                                          minTemp: data.titleData.minTemp,
                                                                          maxTemp: data.titleData.maxTemp,
                                                                          backgroundImage: data.titleData.backgroundImage))
            
            cityWeatherView.tapAction = { [weak self] in
                self?.presentCityWeater(withCityIndex: index)
            }
            
            cityStackView.addArrangedSubview(cityWeatherView)
        }
        
        cityStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    private func presentCityWeater(withCityIndex index: Int) {
        let viewController = WeatherViewController()
        viewController.setupWeatherView(WeatherViewController.InputData(city: index))
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
    }
    
    private func setupScalePickerView() {
        unitSelectionView.addSubview(scalePickerView)
        scalePickerView.backgroundColor = .systemGray5
        scalePickerView.layer.cornerRadius = 12
        scalePickerView.dataSource = self
        scalePickerView.delegate = self
        scalePickerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(80)
        }
    }
    
    private func setupInfoButton() {
        contentView.addSubview(infoButton)
        infoButton.backgroundColor = .systemGray
        infoButton.setTitle(Constants.infoButtonTitle.text, for: .normal)
        infoButton.setTitleColor(.black, for: .normal)
        infoButton.addTarget(self, action: #selector(onInfoButtonTap), for: .touchUpInside)
        infoButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(unitSelectionView.snp.bottom).offset(20)
        }
    }
    
    private func setupNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        
        navigationBar?.prefersLargeTitles = true
        navigationBar?.tintColor = .white
        navigationBar?.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(icon: .ellipsisCircle),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onSwitchButtonTap))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(icon: .infoCircle),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(onDetailedWeatherButtonTap))
    }
    
    @objc private func onSwitchButtonTap(button: UIButton) {
        let isSelectionHidden = unitSelectionView.isHidden
        unitSelectionView.isHidden = isSelectionHidden ? false : true
    }
    
    @objc private func onDetailedWeatherButtonTap() {
        let viewController = UINavigationController(rootViewController: DetailedWeatherViewController())
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
        
    }
}

extension CitySelectionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        scales.count
    }
    
}

extension CitySelectionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        scales[row]
//MARK: UnitSelectionDelegate
extension CitySelectionViewController: UnitSelectionDelegate {
    func pickScale(_ unit: String) {
        print(unit)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedScale  = scales[row]
    func openInfo() {
        onInfoButtonTap()
    }
}
