//
//  TempRangeView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/4/24.
//

import UIKit
import SnapKit

final class TempRangeView: UIView {
    struct InputData {
        let minTemp: Double
        let maxTemp: Double
        let minDayTemp: Double
        let maxDayTemp: Double
        let currentTemt: Double?
        let icon: UIImage
    }
    
    enum Constants {
        case title
        
        var text: String {
            switch self {
            case .title: return "Прогноз на 10 дней"
            }
        }
    }
    
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blueBackground.withAlphaComponent(0.5)
        layer.cornerRadius = 12
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = Constants.title.text
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(10)
        }
    }
}
