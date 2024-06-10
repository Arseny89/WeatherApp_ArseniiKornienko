//
//  APIEndpointProvider.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/9/24.
//

import UIKit

enum Config {
    case config
    
    var configName: String {
        switch self {
        case .config: return "Config"
        }
    }
}

class APIEndpointProvider {
    let url: URL
    let appID: String
    private let scheme: String
    private let host: String
    private let apiVersion: String
    
    init(for config: Config) {
        var format = PropertyListSerialization.PropertyListFormat.xml
        guard let path = Bundle.main.path(forResource: config.configName, ofType: "plist"),
              let file = FileManager.default.contents(atPath: path),
              let configuration = try? PropertyListSerialization.propertyList(
                from: file,
                options: .mutableContainersAndLeaves,
                format: &format
              ) as? [String: Any] else {
            fatalError("\(config.configName).plist not found")
        }
        appID = configuration["appID"] as! String
        let weatherAPI = configuration["weatherAPI"] as! [String: Any]
        scheme = weatherAPI["scheme"] as! String
        host = weatherAPI["host"] as! String
        apiVersion = weatherAPI["apiVersion"] as! String
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "/" + apiVersion
        url = urlComponents.url!
    }
    
    //MARK: CurrentWeather
    struct CurrentWeather: Codable {
        let name: String
        let timezone: Int
        let country: String
        let coordinates: Coordinates
        let main: WeatherItem
        let weather: [WeatherConditions]
    }
}
