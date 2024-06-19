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
    typealias Item = CitySelectionViewModel.Item
    private enum Constants {
        case infoButtonTitle
        case url
        case title
        case searchBarTitle
        
        var text: String {
            switch self {
            case .infoButtonTitle: return "Show info"
            case .url: return "https://www.meteoinfo.ru/t-scale"
            case .title: return "Погода"
            case .searchBarTitle: return "Поиск города или аэропорта"
            }
        }
    }
    
    var viewModel: CitySelectionViewModelInput!
    var sections: [Section] = [] {
        didSet {
            reloadDataSource()
        }
    }
    var errorMessage: String = ""
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    private var snapshot: NSDiffableDataSourceSnapshot<Section, Item>! = nil
    private var cityCollectionView: UICollectionView?
    private let unitSelectionView = UnitSelectionView()
    private let weatherView = WeatherViewController()
    private let citySearchViewController = CitySearchViewController()
    private let cityTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = Constants.title.text
        
        viewModel?.output = self
        setupNavigationBar()
        setupCityCollectionView()
        setupUnitSelectionView()
        presentCityWeater(with: sections.first?.items.first ?? .emptyData)
        createDataSource()
        reloadDataSource()
    }
    
    private func reloadDataSource() {
        snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource?.apply(snapshot)
    }
    
    private func createDataSource() {
        guard let cityCollectionView else { return }
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: cityCollectionView
        ) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self else { return UICollectionViewCell() }
            let item = sections[indexPath.section].items[indexPath.row]
            let cell = collectionView.dequeueCell(CityWeatherCell.self, for: indexPath)
            cell.setupCityWeather(item.titleData)
            return cell
        }
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
    
    private func setupCityCollectionView() {
        cityCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        guard let cityCollectionView else { return }
        view.addSubview(cityCollectionView)
        cityCollectionView.backgroundColor = .clear
        cityCollectionView.delegate = self
        cityCollectionView.registerCell(CityWeatherCell.self)
        cityCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    private func presentCityWeater(with data: CityWeatherData?) {
        let viewController = WeatherViewController()
        viewController.errorMessage = errorMessage
        viewController.viewModel = WeatherViewModel(with: data)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
        errorMessage = ""
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
        citySearchViewController.viewModel = CitySearchViewModel(cityListProvider: CityListProvider())
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
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(section: createCitySection())
        return layout
    }
    
    private func createCitySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(120)
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
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        return layoutSection
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

//MARK: CityCollectionView Delegate
extension CitySelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCity = sections[indexPath.section].items[indexPath.row]
        presentCityWeater(with: selectedCity)
    }
}

extension CitySelectionViewController: CitySelectionViewModelOutput {    
}
