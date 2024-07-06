//
//  CitySearchView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/26/24.
//

import UIKit
import SnapKit
protocol CitySearchViewControllerDelegate {
    func select(_ city: CityData)
}
final class CitySearchViewController: UIViewController {
    var viewModel: CitySearchViewModelInput!
    var cityList: [CityData] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var searchText = ""
    var delegate: CitySearchViewControllerDelegate?
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
    
    private func getAttributedText(for indexPath: IndexPath) -> NSAttributedString? {
        let city = cityList[indexPath.row]
        var text = ["\(city.name)", "\(city.country)"]
        switch city.state.isEmpty {
        case false: text.insert("\(city.state)", at: 1)
        default: break
        }
        
        let attributedText = NSMutableAttributedString(
            string: text.joined(separator: ", "),
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        let textRange = (text.joined().lowercased() as NSString).range(of: searchText)
        attributedText.addAttributes([.foregroundColor: UIColor.white], range: textRange)
        
        return attributedText
    }
}

//MARK: TableView Delegate
extension CitySearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cityCellId, for: indexPath)
        cell.textLabel?.attributedText = getAttributedText(for: indexPath)
        cell.backgroundColor = .clear
        let bgColorView = UIView()
        bgColorView.backgroundColor = .white.withAlphaComponent(0.3)
        cell.selectedBackgroundView = bgColorView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(cityList[indexPath.row])
        delegate?.select(cityList[indexPath.row])
        dismiss(animated: true)
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
