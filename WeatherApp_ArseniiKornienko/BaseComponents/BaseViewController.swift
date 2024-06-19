//
//  BaseViewController.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/14/24.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    enum Constants: String {
        case alertTitle = "Error"
        case alertActionTitle = "OK"
    }
    func presentAlert(title: String?, subtitle: String, actionTitle: String, action: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle,
                                                style: .default,
                                                handler: { _ in action() }))
        present(alertController, animated: true)
    }
}
