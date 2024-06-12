//
//  CitySearchView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/26/24.
//

import UIKit
import SnapKit

final class CitySearchViewController: UIViewController {
    var viewModel: CitySearchViewModelInput!
    var cityList: [CityData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private let tableView = UITableView()
    private let cityCellId = "cityNameCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.output = self
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
        cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cityCellId, for: indexPath)
        cell.textLabel?.attributedText = viewModel.getAttributedText(for: indexPath)
        cell.backgroundColor = .clear
        let bgColorView = UIView()
        bgColorView.backgroundColor = .white.withAlphaComponent(0.3)
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(cityList[indexPath.row])
    }
}
//MARK: UISearchResultUpdating
extension CitySearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.searchTextField.text else { return }
        let searchText = text.lowercased()
        view.backgroundColor = .black.withAlphaComponent(searchText.isEmpty ? 0.5 : 1)
        viewModel.filterCity(with: searchText)
    }
}

extension CitySearchViewController: CitySearchViewModelOutput {
    
}
