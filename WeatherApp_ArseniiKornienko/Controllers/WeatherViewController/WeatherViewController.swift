//
//  ViewController.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/4/24.
//

import UIKit
import SnapKit

class WeatherViewController: BaseViewController {
    private enum Images {
        case clock
        case calendar
        
        var uiImage: UIImage {
            switch self {
            case .clock:
                UIImage(icon: .clock)?.withConfiguration(
                    UIImage.SymbolConfiguration(weight: .heavy)
                ) ?? UIImage.checkmark
            case .calendar:
                UIImage(icon: .calendar)?.withConfiguration(
                    UIImage.SymbolConfiguration(weight: .heavy)
                ) ?? UIImage.checkmark
            }
        }
    }
    var viewModel: WeatherViewModelInput!
    var dataSource: [WeatherViewModel.Section] = []
    let bottomView = BottomView()
    var errorMessage = ""
    var cityID: Int?
    private var cellColor = UIColor()
    private let background = UIImageView()
    private let currentWeatherView = CurrentWeatherView()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let scrollView = UIScrollView()
    private let titleView = UIView()
    private let topView = UIView()
    private var weekBarColor = UIColor()
    private var prevLocation = CGFloat()
    private var totalScroll = CGFloat()
    private var stickyTableHeader = StickyTableHeader()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupBackground()
        setupTitleView()
        setupCurrentWeatherView()
        setupBottomView()
        bottomView.listButton.addTarget(self, action: #selector(onListButtonTap), for: .touchUpInside)
        viewModel?.output = self
        viewModel?.viewDidLoad()
        presentAlert()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupScrollView()
        setupTableView()
        setupStickyTableHeader()
        view.bringSubviewToFront(bottomView)
    }
    
    func presentAlert() {
        if !errorMessage.isEmpty {
            presentAlert(title: Constants.alertTitle.rawValue,
                         subtitle: errorMessage,
                         actionTitle: Constants.alertActionTitle.rawValue) {
            }
        } else { return }
    }
    
    private func setupScrollView() {
        let topInset = currentWeatherView.topStackView.frame.height
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.layer.cornerRadius = 10
        scrollView.layer.masksToBounds = true
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(topInset + 15)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupStickyTableHeader() {
        view.addSubview(stickyTableHeader)
        stickyTableHeader.layer.cornerRadius = 10
        stickyTableHeader.isHidden = true
        stickyTableHeader.backgroundColor = cellColor
        stickyTableHeader.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.top.equalTo(currentWeatherView.topStackView.snp.bottom).inset(-15)
            make.horizontalEdges.equalTo(background).inset(20)
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
        let topInset = currentWeatherView.lowerStackView.frame.height
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
            make.top.equalToSuperview().inset(topInset)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalTo(background)
            make.height.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupTitleView() {
        view.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
    }
    
    private func updateTitleView() {
        let topPadding = titleView.frame.height - currentWeatherView.frame.height
        let alpha = 1 - (scrollView.contentOffset.y/30)
        
        titleView.snp.updateConstraints { make in
            if scrollView.contentOffset.y/5 < topPadding {
                make.top.equalTo(view.safeAreaLayoutGuide).inset(-scrollView.contentOffset.y/5)
            } else {
                make.top.equalTo(view.safeAreaLayoutGuide).inset(-topPadding)
            }
        }
        
        currentWeatherView.tempLimits.alpha = alpha
        currentWeatherView.currentTemp.alpha = 3 + alpha
        currentWeatherView.descriptionLabel.alpha = 1 + alpha
        
        if currentWeatherView.currentTemp.alpha <= 0 {
            currentWeatherView.hiddenLabel.alpha = -3 * alpha
        } else {
            currentWeatherView.hiddenLabel.alpha = 0
        }
    }
    
    private func updateStickyHeader() {
        let alpha = 1 - (scrollView.contentOffset.y/30)
        if scrollView.contentOffset.y >= 156 {
            stickyTableHeader.isHidden = false
            stickyTableHeader.titleLabel.text = WeatherViewElements.dayTemp.title
            stickyTableHeader.titleImageView.image = WeatherViewElements.dayTemp.icon
        } else {
            stickyTableHeader.isHidden = true
        }
        if scrollView.contentOffset.y >= 272 && scrollView.contentOffset.y <= 338  {
            stickyTableHeader.alpha = 9 + alpha
            tableView.cellForRow(at: [0, 1])?.isHidden = true
        } else {
            stickyTableHeader.alpha = 1
            tableView.cellForRow(at: [0, 1])?.isHidden = false
        }
        
        if scrollView.contentOffset.y >= 338 {
            stickyTableHeader.titleLabel.text = WeatherViewElements.tempRange.title
            stickyTableHeader.titleImageView.image = WeatherViewElements.tempRange.icon
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
        cell.backgroundColor = cellColor
        bottomView.backgroundColor = cell.backgroundColor
        return cell
    }
}

extension WeatherViewController: WeatherViewModelOutput {
    func setupCellColor(with data: CityWeatherData) {
        switch data.titleData.backgroundImage {
        case UIImage(image: .sunSky), UIImage(image: .clouds):
            cellColor = .blueBackground
            weekBarColor = cellColor.darker(by: 10)
        case UIImage(image: .starNight), UIImage(image: .cloudNight):
            cellColor = .nightBlue
            weekBarColor = cellColor.darker(by: 50)
        case UIImage(image: .cloudsGrey):
            cellColor = .systemGray2
            weekBarColor = cellColor.darker(by: 20)
        case UIImage(image: .rainDay):
            cellColor = .rainGray
            weekBarColor = cellColor.darker(by: 50)
        default:
            cellColor = .blueBackground
            weekBarColor = cellColor.darker(by: 10)
        }
    }
    
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

extension WeatherViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateTitleView()
        updateStickyHeader()
    }
}
