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
    var cityID: Int?
    private let background = UIImageView()
    private let currentWeatherView = CurrentWeatherView()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let scrollView = UIScrollView()
    private let titleView = UIView()
    private let topView = UIView()
    private var weekBarColor = UIColor()
    private var prevLocation = CGFloat()
    private var totalScroll = CGFloat()
    private var gestureRecognizer = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupBackground()
        setupScrollView()
        setupTitleView()
        bottomView.listButton.addTarget(self, action: #selector(onListButtonTap), for: .touchUpInside)
        setupBottomView()
        setupCurrentWeatherView()
        setupTableView()
        viewModel?.output = self
        viewModel?.viewDidLoad()
        presentAlert()
        setupGestureRecognizer()
    }
    
    func presentAlert() {
        if !errorMessage.isEmpty {
            presentAlert(title: Constants.alertTitle.rawValue,
                         subtitle: errorMessage,
                         actionTitle: Constants.alertActionTitle.rawValue) {
            }
        } else { return }
    }
    
    private func setupGestureRecognizer() {
        gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panHandler(_:)))
        gestureRecognizer.delegate = self
        scrollView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
    private func setupBackground() {
        view.addSubview(background)
        background.contentMode = .scaleAspectFill
        background.isUserInteractionEnabled = false
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func panHandler(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view).y
        switch gesture.state {
        case .began:
            prevLocation = location
        default:
            break
        }
        
        totalScroll += prevLocation - location
        totalScroll = totalScroll < 0 ? 0 : totalScroll
        prevLocation = location
        if totalScroll > 200 {
            tableView.setContentOffset(CGPoint(x: 0, y: totalScroll - 200), animated: false)
        } else {
            scrollView.setContentOffset(.zero, animated: false)
            updateTitleView()
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
        scrollView.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = .white.withAlphaComponent(0.5)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.registerCell(TitleCell.self)
        tableView.registerCell(DayTempCell.self)
        tableView.registerCell(TempRangeCell.self)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
            make.horizontalEdges.equalTo(background)
            make.height.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupTitleView() {
        scrollView.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    func updateTitleView() {
        titleView.snp.updateConstraints { update in
            update.top.equalToSuperview()
            update.height.equalTo(300 - totalScroll)
        }
        let alpha = 1 - (totalScroll/150)
        currentWeatherView.tempLimits.alpha = alpha
        currentWeatherView.currentTemp.alpha = alpha
        currentWeatherView.descriptionLabel.alpha = alpha
        if alpha <= 0 {
            currentWeatherView.hiddenLabel.alpha = -3 * alpha
        } else {
            currentWeatherView.hiddenLabel.alpha = 0
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
            (cell as? TempRangeCell)?.setupDayRange(data, cell.backgroundColor?.darker(by: 10) ?? UIColor.darkBlue)
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

extension WeatherViewController: UIGestureRecognizerDelegate {

}
