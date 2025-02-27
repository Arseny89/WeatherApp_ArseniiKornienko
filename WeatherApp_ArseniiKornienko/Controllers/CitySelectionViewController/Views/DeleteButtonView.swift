//
//  DeleteButtonView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 2/4/25.
//

import UIKit

class DeleteButtonView: UIView {
    private let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupContainerView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContainerView() {
        let contentView = UIView(frame: CGRect(x: 10, y: 0, width: 400, height: 100))
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
        addSubview(contentView)
    }
}
