//
//  LocationProvider.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/26/24.
//

import Foundation
import CoreLocation
import UIKit

protocol LocationProviderDelegate: AnyObject {
    func setCurrentLocation(coordinates: Coordinates?)
    func presentAlert(alert: UIAlertController)
}

final class LocationProvider: NSObject {
    enum Constants: String {
        case alertTitle = "Can't find location"
        case alertMessage = "Please turn on location service"
        case alertRightButton = "Ok"
        case alertLeftButton = "Cancel"
    }
    
    weak var delegate: LocationProviderDelegate?
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    func getCurrentLocation() {
        checkAuthorization()
    }
    
    private func checkAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .denied, .restricted:
            showSettingsAlert()
        case .authorizedAlways,
                .authorizedWhenInUse,
                .authorized:
            locationManager.requestLocation()
        @unknown default:
            break
        }
    }
    
    private func showSettingsAlert() {
        let alertController = UIAlertController(
            title: Constants.alertTitle.rawValue,
            message: Constants.alertMessage.rawValue,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(
            title: Constants.alertRightButton.rawValue,
            style: .default
        ) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString)
            else { return }
            UIApplication.shared.open(settingsURL)
        })
        alertController.addAction(UIAlertAction(title: Constants.alertLeftButton.rawValue,
                                                style: .cancel))
        
        delegate?.presentAlert(alert: alertController)
    }
}

extension LocationProvider: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, 
                         didUpdateLocations locations: [CLLocation]) {
            guard let coordinate = locations.last?.coordinate else { return }
            
            delegate?.setCurrentLocation(
                coordinates: Coordinates(latitude: coordinate.latitude,
                                         longitude: coordinate.longitude)
            )
    }
    
    func locationManager(_ manager: CLLocationManager, 
                         didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
    
}
