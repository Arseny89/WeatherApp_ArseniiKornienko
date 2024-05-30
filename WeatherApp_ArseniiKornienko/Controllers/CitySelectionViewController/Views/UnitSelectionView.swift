//
//  UnitSelectionView.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 5/22/24.
//

import UIKit
import SnapKit

protocol UnitSelectionDelegate: AnyObject {
    func pickScale(_ unit: String)
    func openInfo()
}

final class UnitSelectionView: UIView {
    
    private let infoButton = UIButton()
    private let scales: [String] = ["º C", "º F", "º K"]
    private let scalePickerView = UIPickerView()
    weak var delegate: UnitSelectionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUnitSelectionView()
        setupScalePickerView()
        setupInfoButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUnitSelectionView() {
        self.backgroundColor = .gray.withAlphaComponent(0.9)
        self.layer.cornerRadius = 12
        snp.makeConstraints { make in
            make.size.equalTo(200)
        }
    }
    
    private func setupScalePickerView() {
        addSubview(scalePickerView)
        scalePickerView.backgroundColor = .none
        scalePickerView.layer.cornerRadius = 12
        scalePickerView.dataSource = self
        scalePickerView.delegate = self
        scalePickerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(80)
        }
    }
    
    private func setupInfoButton() {
        addSubview(infoButton)
        let image = UIImage(icon: .infoSquare)?.withConfiguration(UIImage.SymbolConfiguration(scale: .large))
        infoButton.setImage(image, for: .normal)
        infoButton.tintColor = .white
        infoButton.addTarget(self, action: #selector(onInfoButtonTap), for: .touchUpInside)
        infoButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
            
        }
    }
    
    @IBAction func onInfoButtonTap(button: UIButton) {
        delegate?.openInfo()
    }
}

extension UnitSelectionView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        scales.count
    }
}

extension UnitSelectionView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        scales[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickScale(scales[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: scales[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
