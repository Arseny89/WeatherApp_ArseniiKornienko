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
    typealias Section = CitySelectionViewModel.Section
    private enum Constants {
        case infoButtonTitle
        case url
        case title
        case searchBarTitle
        
        var text: String {
            switch self {
            case .infoButtonTitle: return "Show info"
            case .url: return "https://www.meteoinfo.ru/t-scale"
            case .title: return "Weather"
            case .searchBarTitle: return "Search for a city or airport"
            }
        }
    }
    
    var viewModel: CitySelectionViewModelInput?
    var sections: [Section] = [] {
        didSet {
            reloadDataSource()
        }
    }
    
    private var currentCityData: CityWeatherData? {
        didSet {
            presentCityWeather(with: currentCityData)
        }
    }
    
    var errorMessage: String = ""
    private var cityID: Int?
    private var dataSource: UICollectionViewDiffableDataSource<Section, CityWeatherData>?
    private var snapshot: NSDiffableDataSourceSnapshot<Section, CityWeatherData>! = nil
    private var cityCollectionView: UICollectionView?
    private let citySearchViewController = CitySearchViewController()
    private let cityTableView = UITableView()
    private let locationProvider = LocationProvider()
    private let cityListProvider: CityListProvider = CityListProviderImpl.shared
    private var isFirstPresentation = true
    private var weatherData: CityWeatherData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = Constants.title.text
        viewModel?.output = self
        setupLocationProvider()
        setupNavigationBar()
        setupCityCollectionView()
        createDataSource()
    }
    
    func sceneWillEnterForeground() {
        viewModel?.getData(forced: false)
    }
    
    private func setupLocationProvider() {
        locationProvider.delegate = self
        locationProvider.getCurrentLocation()
    }
    
    private func reloadDataSource() {
        snapshot = NSDiffableDataSourceSnapshot<Section, CityWeatherData>()
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource?.apply(snapshot)
    }
    
    private func createDataSource() {
        guard let cityCollectionView else { return }
        dataSource = UICollectionViewDiffableDataSource<Section, CityWeatherData>(
            collectionView: cityCollectionView
        ) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self else { return UICollectionViewCell() }
            let item = sections[indexPath.section].items[indexPath.row]
            let cell = collectionView.dequeueCell(CityWeatherCell.self, for: indexPath)
            cell.setupCityWeather(item.titleData)
            return cell
        }
    }
    
    private func onInfoButtonTap() {
        guard let url = URL(string: Constants.url.text) else { return }
        let webViewController = WebViewController()
        let viewController = UINavigationController(rootViewController: webViewController)
        webViewController.openUrl(url)
        self.present(viewController, animated: true)
    }
    
    private func setupCityCollectionView() {
        cityCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        guard let cityCollectionView else { return }
        view.addSubview(cityCollectionView)
        cityCollectionView.backgroundColor = .clear
        cityCollectionView.delegate = self
        cityCollectionView.registerCell(CityWeatherCell.self)
        cityCollectionView.showsVerticalScrollIndicator = false
        cityCollectionView.snp.makeConstraints { make in
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
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(section: createCitySection())
        return layout
    }
    
    private func createCitySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(100)
        )
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [layoutItem]
        )
        
        layoutGroup.interItemSpacing = NSCollectionLayoutSpacing.fixed(20)

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        return layoutSection
    }
}

//MARK: CityCollectionView Delegate
extension CitySelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCity = sections[indexPath.section].items[indexPath.row]
        presentCityWeather(with: selectedCity)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if currentCityData ==  nil,
            sections.first?.items.count == cityListProvider.selectedCityList.count {
            currentCityData = sections[0].items[0]
        }
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
