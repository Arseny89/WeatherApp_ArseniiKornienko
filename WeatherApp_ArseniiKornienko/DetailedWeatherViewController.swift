//
//  DetailedWeatherViewController.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/14/24.
//

import UIKit
import SnapKit

final class DetailedWeatherViewController: UIViewController {
    
    enum Constants {
        case title
        
        var text: String {
            switch self {
            case .title: return "Погодные условия"
            }
        }
    }
    
    private let titleView = UIStackView()
    private let titleLabel = UILabel()
    private let titleImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupNavigationBar()
        setupTitleLabel()
        setupTitleImage()
    }
    
    private func setupTitleLabel() {
        titleView.addSubview(titleLabel)
        titleLabel.text = Constants.title.text
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupTitleImage() {
        titleView.addSubview(titleImage)
        titleImage.image = UIImage.Images.cloudSun.image
        titleImage.snp.makeConstraints { make in
            make.trailing.equalTo(titleLabel.snp.leading).offset(-5)
            make.centerY.equalTo(titleLabel)
        }
    }
    
    private func setupNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        let imageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .systemGray2)
        navigationBar?.tintColor = .white
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.titleView = titleView
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage.Images.xmarkCircle.image?.withConfiguration(imageConfiguration),
            style: .plain,
            target: self,
            action: #selector(onRightBarButtonTap)
        )
    }
    
    @objc func onRightBarButtonTap() {
        self.navigationController?.dismiss(animated: true)
    }
}
