//
//  StickyTableHeader.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 11/29/24.
//

import Foundation
import UIKit
import SnapKit

final class StickyTableHeader: UIView {
    var titleLabel = UILabel()
    let titleImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTitleIcon()
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleIcon() {
        addSubview(titleImageView)
        titleImageView.tintColor = .white
        titleImageView.alpha = 0.5
        titleImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(7)
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.alpha = 0.5
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleImageView.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
        }
    }
}
