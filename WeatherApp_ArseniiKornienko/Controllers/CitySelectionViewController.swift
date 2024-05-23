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
    
    private enum Constants {
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
    
    private let unitSelectionView = UnitSelectionView()
    private let contentView = UIView()
    private let cityWeatherView = CityWeatherView()
    private let weatherView = WeatherViewController()
    private let cityStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = Constants.title.text
        
        setupNavigationBar()
        setupContentView()
        setupCityStackView()
        setupUnitSelectionView()
        presentCityWeater(withCityIndex: 0)
    }
    
    private func setupUnitSelectionView() {
        guard let navigationControllerView = self.navigationController?.view else { return }
        navigationControllerView.addSubview(unitSelectionView)
        unitSelectionView.isHidden = true
        unitSelectionView.delegate = self
        unitSelectionView.snp.makeConstraints { make in
            make.trailing.equalTo(navigationControllerView.safeAreaLayoutGuide).inset(15)
            make.top.equalTo(navigationControllerView.safeAreaLayoutGuide).inset(40)
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

//MARK: UnitSelectionDelegate
extension CitySelectionViewController: UnitSelectionDelegate {
    func pickScale(_ unit: String) {
        print(unit)
    }
    
    func openInfo() {
        onInfoButtonTap()
    }
}
