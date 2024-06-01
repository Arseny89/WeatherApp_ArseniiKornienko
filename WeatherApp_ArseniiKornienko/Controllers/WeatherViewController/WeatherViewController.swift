//
//  ViewController.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/4/24.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    struct InputData {
        let city: Int
    }
    private enum Constants: Int {
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
    var viewModel: WeatherViewModelInput!
    var dataSource: [WeatherViewModel.Section] = []
    let bottomView = BottomView()
    private let weatherData = MOCKData.data
    private let backgroundImage = UIImageView()
    private let currentWeatherView = CurrentWeatherView()
    private let dayTempView = DayTempCell()
    private let tempRangeView = TempRangeCell()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let scrollView = UIScrollView()
    private let titleView = UIView()
    private var weekBarColor = UIColor()
    private var city: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bottomView.listButton.addTarget(self, action: #selector(onListButtonTap), for: .touchUpInside)
        setupBackgroundImage(weatherData[city])
        setupBottomView()
        setupTitleView()
        setupCurrentWeatherView()
        setupTableView()
        viewModel.output = self
        viewModel.viewDidLoad()
    }
    
    func setupWeatherView(_ data: InputData) {
        city = data.city
    }
    
    private func setupBackgroundImage(_ data: MOCKData?) {
        view.addSubview(backgroundImage)
        backgroundImage.contentMode = .scaleAspectFill
        guard let data else { return }
        backgroundImage.image = data.titleData.backgroundImage
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupCellsColor (_ data: MOCKData?, _ cell: UITableViewCell) {
        guard let data else { return }
        switch data.titleData.backgroundImage {
        case UIImage(image: .sunSky), UIImage(image: .clouds):
            cell.backgroundColor = .blueBackground.withAlphaComponent(0.7)
            weekBarColor = cell.backgroundColor?.darker(by: 10) ?? .darkBlue
        case UIImage(image: .starNight), UIImage(image: .cloudNight):
            cell.backgroundColor = .nightBlue.withAlphaComponent(0.7)
            weekBarColor = cell.backgroundColor?.darker(by: 50) ?? .darkBlue
        case UIImage(image: .cloudsGrey):
            cell.backgroundColor = .systemGray2.withAlphaComponent(0.7)
            weekBarColor = cell.backgroundColor?.darker(by: 20) ?? .darkBlue
        default:
            return
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = .white.withAlphaComponent(0.5)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(TitleCell.self)
        tableView.registerCell(DayTempCell.self)
        tableView.registerCell(TempRangeCell.self)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
    }
    
    private func setupTitleView() {
        view.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupCurrentWeatherView() {
        titleView.addSubview(currentWeatherView)
        currentWeatherView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupBottomView() {
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

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    
}

extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = dataSource[indexPath.section].items[indexPath.row]
        let cell: UITableViewCell
        switch item {
        case .title(let data):
            cell = tableView.dequeue(TitleCell.self, for: indexPath)
            (cell as? TitleCell)?.setupTitleCell(data)
            
        case .dayTemp(let data):
            cell = tableView.dequeue(DayTempCell.self, for: indexPath)
            (cell as? DayTempCell)?.setupDayTemp(data)
            
        case .tempRange(let data):
            cell = tableView.dequeue(TempRangeCell.self, for: indexPath)
            (cell as? TempRangeCell)?.setupDayRange(data, weekBarColor)
        }
        cell.selectionStyle = .none
        setupCellsColor(weatherData[city], cell)
        return cell
    }
}

extension WeatherViewController: WeatherViewModelOutput {
    func setupCurrentWeatherView(with data: CurrentWeatherView.InputData) {
        currentWeatherView.setupCurrentWeather(data)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
