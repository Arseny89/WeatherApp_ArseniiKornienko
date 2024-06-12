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
        guard let configAppId = configuration["appID"] as? String,
        let weatherAPI = configuration["weatherAPI"] as? [String: Any],
        let weatherApiScheme = weatherAPI["scheme"] as? String,
        let weatherApiHost = weatherAPI["host"] as? String,
        let weatherApiVersion = weatherAPI["apiVersion"] as? String
        else {
            fatalError()
        }
        
        appID = configAppId
        scheme = weatherApiScheme
        host = weatherApiHost
        apiVersion = weatherApiVersion
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = "/" + apiVersion
        url = urlComponents.url!
    }
}
