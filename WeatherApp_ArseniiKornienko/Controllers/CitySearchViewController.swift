//
//  CitySearchView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/26/24.
//

import UIKit
import SnapKit

final class CitySearchViewController: UIViewController {
    
    private let tableView = UITableView()
    private let cityCellId = "cityNameCell"
    private let cityList = ["Glendale",
                            "Moscow" ,
                            "Mexico City",
                            "New York",
                            "Paris",
                            "Barcelona",
                            "Tokyo",
                            "Toronto",
                            "Las Vegas",
                            "Melbourne"]
    
    private var filteredCityList: [String] = []
    private var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cityCellId)
        tableView.snp.makeConstraints { make in
            
            make.edges.equalToSuperview()
        }
    }
}

//MARK: TableView Delegate
extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cityCellId, for: indexPath)
        let city = filteredCityList[indexPath.row]
        let attributedText = NSMutableAttributedString(
            string: city,
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        let textRange = (city.lowercased() as NSString).range(of: searchText)
        attributedText.addAttributes([.foregroundColor: UIColor.white], range: textRange)
        cell.textLabel?.attributedText = attributedText
        cell.backgroundColor = .clear
        let bgColorView = UIView()
        bgColorView.backgroundColor = .white.withAlphaComponent(0.3)
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let index = cityList.firstIndex(of: filteredCityList[indexPath.row]) else { return }
        let viewController = SelectedCityViewController()
        viewController.setupWeatherView(WeatherViewController.InputData(city: index))
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .popover
        self.present(navigationController, animated: true)
    }
}
//MARK: UISearchResultUpdating
extension CitySearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.searchTextField.text else { return }
        self.searchText = text.lowercased()
        view.backgroundColor = .black.withAlphaComponent(searchText.isEmpty ? 0.5 : 1)
        filteredCityList = cityList.filter { $0.lowercased().contains(searchText) }
        tableView.reloadData()
    }
}
