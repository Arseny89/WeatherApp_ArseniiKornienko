//
//  SelectedCityView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/27/24.
//

import UIKit
import SnapKit

final class SelectedCityViewController: WeatherViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.tintColor = .white
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Отменить",
            style: .plain,
            target: self,
            action: #selector(onLeftBarButtonTap)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить",
                                                            style: .plain,
                                                            target: self,
                                                            action: .none
        )
    }
    
    override func setupBottomView() {
        super.setupBottomView()
        bottomView.snp.remakeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(bottomView.snp.bottom)
        }
    }
    
    @objc func onLeftBarButtonTap() {
        self.navigationController?.dismiss(animated: true)
    }
}
