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
    private let cityWeatherView = CityWeatherView()
    private let scalePickerView = UIPickerView()
    private let scales: [String] = ["º C", "º F", "º K"]
    private var pickedScale: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = Constants.title.text

        setupNavigationBar()
        setupUnitSelectionView()
        setupCityWeatherView()
        setupScalePickerView()
        setupInfoButton()
    }
    
    private func setupUnitSelectionView() {
        view.addSubview(unitSelectionView)
        unitSelectionView.backgroundColor = .green
        unitSelectionView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    private func setupCityWeatherView() {
        view.addSubview(cityWeatherView)
        cityWeatherView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(120)
           make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
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
        view.addSubview(infoButton)
        infoButton.backgroundColor = .systemGray
        infoButton.setTitle(Constants.infoButtonTitle.text, for: .normal)
        infoButton.setTitleColor(.black, for: .normal)
        infoButton.addTarget(self, action: #selector(onInfoButtonTap), for: .touchUpInside)
        infoButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(cityWeatherView.snp.bottom).offset(20)
        }
    }
    
    private func setupNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        
        navigationBar?.prefersLargeTitles = true
        navigationBar?.tintColor = .white
        navigationBar?.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.Images.ellipsisCircle.image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onSwitchButtonTap))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.Images.infoCircle.image,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(onDetailedWeatherButtonTap))
    }
    
    @objc private func onSwitchButtonTap(button: UIButton) {
        let isSelectionHidden = unitSelectionView.isHidden
        unitSelectionView.isHidden = isSelectionHidden ? false : true
    }
    
    @objc private func onInfoButtonTap(button: UIButton) {
        if let url = URL(string: Constants.url.text) {
            let webViewController = WebViewController()
            let viewController = UINavigationController(rootViewController: webViewController)
            webViewController.openUrl(url)
            self.present(viewController, animated: true)
        }
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
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedScale  = scales[row]
    }
}
