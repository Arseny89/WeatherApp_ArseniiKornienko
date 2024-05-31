//
//  TitleView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/29/24.
//

import UIKit
import SnapKit

final class TitleCell: UITableViewCell {
    
    struct InputData {
        let title: String
        let icon: UIImage
    }
    
    static let id = String(describing: TitleCell.self)
    private let titleLabel = UILabel()
    private let titleIcon = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTitleImage()
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleImage() {
        contentView.addSubview(titleIcon)
        titleIcon.tintColor = .white
        titleIcon.alpha = 0.5
        titleIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(7)
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.alpha = 0.5
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleIcon.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupTitleCell(_ data: InputData) {
        titleIcon.image = data.icon
        titleLabel.text = data.title
    }
}
