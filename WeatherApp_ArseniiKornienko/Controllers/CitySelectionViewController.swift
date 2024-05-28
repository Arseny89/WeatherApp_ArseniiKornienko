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
    private let cityWeatherView = CityWeatherView()
    private let weatherView = WeatherViewController()
    private let citySearchViewController = CitySearchViewController()
    private let cityTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = Constants.title.text
        
        setupNavigationBar()
        setupCityTableView()
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
    
    private func setupCityTableView() {
        view.addSubview(cityTableView)
        cityTableView.backgroundColor = .clear
        cityTableView.dataSource = self
        cityTableView.delegate = self
        cityTableView.sectionHeaderTopPadding = 0
        cityTableView.showsVerticalScrollIndicator = false
        cityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        cityTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
    }
    
    private func presentCityWeater(withCityIndex index: Int) {
        let viewController = WeatherViewController()
        viewController.setupWeatherView(WeatherViewController.InputData(city: index))
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
    }
    
    private func setupSearchController() -> UISearchController {
        let searchController = UISearchController(searchResultsController: citySearchViewController)
        searchController.searchResultsUpdater = citySearchViewController
        searchController.searchBar.searchTextField.placeholder = "Поиск города или аэропорта"
        searchController.searchBar.setImage(UIImage(icon: .micIcon), for: .bookmark, state: .normal)
        searchController.searchBar.showsBookmarkButton = true
        return searchController
    }
    
    private func setupNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.barStyle = .black
        navigationBar?.prefersLargeTitles = true
        navigationBar?.tintColor = .white
        navigationBar?.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.searchController = setupSearchController()
        navigationItem.hidesSearchBarWhenScrolling = false
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

extension CitySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        MOCKData.data.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cityWeatherView = CityWeatherView()
        let data = MOCKData.data[indexPath.section]
        cityWeatherView.setupCityWeather(CurrentWeatherView.InputData(title: data.titleData.title,
                                                                      subtitle: data.titleData.subtitle,
                                                                      currentTemp: data.titleData.currentTemp,
                                                                      description: data.titleData.description,
                                                                      minTemp: data.titleData.minTemp,
                                                                      maxTemp: data.titleData.maxTemp,
                                                                      backgroundImage: data.titleData.backgroundImage))
        cell.addSubview(cityWeatherView)
        cityWeatherView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentCityWeater(withCityIndex: indexPath.section)
    }
}
