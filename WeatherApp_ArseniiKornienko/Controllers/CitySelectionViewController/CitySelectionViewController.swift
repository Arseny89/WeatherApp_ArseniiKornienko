//
//  CitySelectionView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/7/24.
//

import UIKit
import SnapKit

final class CitySelectionViewController: UIViewController {
    typealias Section = CitySelectionViewModel.Section
    private enum Constants {
        case infoButtonTitle
        case title
        case searchBarTitle
        
        var text: String {
            switch self {
            case .infoButtonTitle: return "Show info"
            case .title: return "Weather"
            case .searchBarTitle: return "Search for a city or airport"
            }
        }
    }
    
    var viewModel: CitySelectionViewModelInput?
    var sections: [Section] = [] {
        didSet {
            reloadTableData()
        }
    }
    
    private var currentLocationData: CityWeatherData? {
        didSet {
            presentCityWeather(with: currentLocationData)
        }
    }
    
    var errorMessage: String = ""
    private var cityID: Int?
    private var tableDataSource: UITableViewDiffableDataSource<Section, CityWeatherData>?
    private var tableSnapshot: NSDiffableDataSourceSnapshot<Section, CityWeatherData>! = nil
    private let citySearchViewController = CitySearchViewController()
    private var cityTableView: UITableView?
    private let locationProvider = LocationProvider()
    private let cityListProvider: CityListProvider = CityListProviderImpl.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = Constants.title.text
        viewModel?.output = self
        setupLocationProvider()
        setupNavigationBar()
        setupCityTableView()
    }
    
    func sceneWillEnterForeground() {
        viewModel?.getData(forced: false)
    }
    
    private func setupLocationProvider() {
        locationProvider.delegate = self
        locationProvider.getCurrentLocation()
    }
    
    private func reloadTableData() {
        tableSnapshot = NSDiffableDataSourceSnapshot<Section, CityWeatherData>()
        tableSnapshot.appendSections(sections)
        for section in sections {
            tableSnapshot.appendItems(section.items, toSection: section)
        }
        tableDataSource?.apply(tableSnapshot, animatingDifferences: true)
        cityTableView?.reloadData()
    }
    
    private func setupCityTableView() {
        cityTableView = UITableView(frame: .zero, style: .grouped)
        guard let cityTableView else { return }
        view.addSubview(cityTableView)
        cityTableView.backgroundColor = .clear
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.rowHeight = 100
        cityTableView.registerCell(CityWeatherTableCell.self)
        cityTableView.showsVerticalScrollIndicator = false
        cityTableView.sectionFooterHeight = 0
        cityTableView.sectionHeaderHeight = 10
        cityTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func presentCityWeather(with data: CityWeatherData?) {
        let viewController = WeatherViewController()
        viewController.errorMessage = errorMessage
        viewController.cityID = data?.id
        viewController.viewModel = WeatherViewModel(with: data)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
    }
    
    private func setupSearchController() -> UISearchController {
        let searchController = UISearchController(searchResultsController: citySearchViewController)
        searchController.searchResultsUpdater = citySearchViewController
        searchController.searchBar.searchTextField.placeholder = Constants.searchBarTitle.text
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
        citySearchViewController.viewModel = CitySearchViewModel()
        citySearchViewController.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

//MARK: CityTableView Delegate
extension CitySelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = sections[indexPath.row].items[indexPath.section]
        presentCityWeather(with: selectedCity)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if currentLocationData == nil,
           sections.first?.items.count == cityListProvider.selectedCityList.count,
           sections.first?.items.first?.dayTempData != nil {
            currentLocationData = sections[0].items[0]
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if sections[indexPath.row].items[indexPath.section].id == .currentCityId {
            return nil
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "") {[weak self] action, view, completionHandler in
            guard let self else { return }
            tableView.beginUpdates()
            tableView.deleteSections([indexPath.section], with: .automatic)
            viewModel?.deleteCity(for: sections[indexPath.row].items[indexPath.section].id!)
            tableSnapshot = NSDiffableDataSourceSnapshot<Section, CityWeatherData>()
            tableSnapshot.appendSections(sections)
            for section in sections {
                tableSnapshot.appendItems(section.items, toSection: section)
            }
            completionHandler(true)
            tableView.endUpdates()
        }
        let deleteButtonView = DeleteButtonView(frame: CGRect(x: 0,
                                                              y: 0,
                                                              width: tableView.frame.width,
                                                              height: tableView.rowHeight))
        
        let renderer = UIGraphicsImageRenderer(bounds: deleteButtonView.bounds)
        let deleteButtonImage = renderer.image { context in
            deleteButtonView.layer.render(in: context.cgContext)
        }
        
        deleteAction.image = UIImage(icon: .trash)
        deleteAction.backgroundColor = UIColor(patternImage: deleteButtonImage)
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

//MARK: CityTableViewDataSource Delegate
extension CitySelectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let numberOfSections = sections.first?.items.count else { return 0 }
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !sections.isEmpty else {
            return UITableViewCell()
        }
        let cell = tableView.dequeue(CityWeatherTableCell.self, for: indexPath)
        cell.setupCityWeather(sections[indexPath.row].items[indexPath.section].titleData)
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

//MARK: ViewModel delegate
extension CitySelectionViewController: CitySelectionViewModelOutput {
}

//MARK: searchController delegate
extension CitySelectionViewController: CitySearchViewControllerDelegate {
    func select(_ city: CityData) {
        navigationItem.searchController?.searchBar.text = nil
        viewModel?.getData(forced: true)
    }
}

//MARK: Location provider delegate
extension CitySelectionViewController: LocationProviderDelegate {
    func setCurrentLocation(coordinates: Coordinates?) {
    }
    
    func presentAlert(alert: UIAlertController) {
        present(alert, animated: true)
    }
}
