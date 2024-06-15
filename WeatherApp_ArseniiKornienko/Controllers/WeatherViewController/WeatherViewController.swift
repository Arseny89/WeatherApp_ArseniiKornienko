//
//  ViewController.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/4/24.
//

import UIKit
import SnapKit

class WeatherViewController: BaseViewController {

    var viewModel: WeatherViewModelInput!
    var dataSource: [WeatherViewModel.Section] = []
    let bottomView = BottomView()
    var errorMessage = ""
    private let background = UIImageView()
    private let currentWeatherView = CurrentWeatherView()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let scrollView = UIScrollView()
    private let titleView = UIView()
    private var weekBarColor = UIColor()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bottomView.listButton.addTarget(self, action: #selector(onListButtonTap), for: .touchUpInside)
        setupBackground()
        setupBottomView()
        setupTitleView()
        setupCurrentWeatherView()
        setupTableView()
        viewModel?.output = self
        viewModel?.viewDidLoad()
        presentAlert()
    }
    
    func presentAlert() {
        if errorMessage.isEmpty == false {
            presentAlert(title: Constants.alertTitle.rawValue, 
                         subtitle: errorMessage,
                         actionTitle: Constants.alertActionTitle.rawValue) {
            }
        } else { return }
    }
    
    private func setupBackground() {
        view.addSubview(background)
        background.contentMode = .scaleAspectFill
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupCellsColor (_ data: CityWeatherData?, _ cell: UITableViewCell) {
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
        cell.backgroundColor = .blueBackground
        bottomView.backgroundColor = cell.backgroundColor
        return cell
    }
}

extension WeatherViewController: WeatherViewModelOutput {
    func setupCurrentWeatherView(with data: CityWeatherData) {
        currentWeatherView.setupCurrentWeather(data)
    }
    
    func setupBackgroundImage(with data: CityWeatherData?) {
        guard let data else { return }
        background.image = data.titleData.backgroundImage
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
