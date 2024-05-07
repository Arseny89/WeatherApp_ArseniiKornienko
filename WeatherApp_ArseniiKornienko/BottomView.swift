//
//  BottomView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/7/24.
//

import UIKit
import SnapKit

final class BottomView: UIView {
    
    private let listButton = UIButton()
    private let divider = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blueBackground.withAlphaComponent(0.5)
        
        setupListButton()
        setupDivider()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDivider() {
        addSubview(divider)
        divider.backgroundColor = .white
        divider.alpha = 0.5
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    private func setupListButton() {
        addSubview(listButton)
        listButton.setImage(
            UIImage(systemName: "list.bullet",
                    withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)),
            for: .normal
        )
        listButton.tintColor = .white
        listButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}

