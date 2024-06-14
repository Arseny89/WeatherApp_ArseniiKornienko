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


enum Endpoint {
    case currentWeather (lat: Double, lon: Double)
    case forecast (lat: Double, lon: Double)
    case currentWeatherId (id: Int)
    case forecastId (id: Int)
    case group (ids: [Int])
    
    var pathComponent: String {
        switch self {
        case .currentWeather, .currentWeatherId:
            return "weather"
        case .forecast, .forecastId:
            return "forecast"
        case .group:
            return "group"
        }
    }
}


class APIEndpointProvider {
    let baseUrl: URL
    private let appID: String
    
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
        guard let configAppID = configuration["appID"] as? String,
              let weatherAPI = configuration["weatherAPI"] as? [String: Any],
              let scheme = weatherAPI["scheme"] as? String,
              let host = weatherAPI["host"] as? String,
              let apiVersion = weatherAPI["apiVersion"] as? String
        else {
            fatalError()
        }
        appID = configAppID
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = apiVersion
        baseUrl = urlComponents.url!
    }
    
    func getURL(for endpoint: Endpoint) -> URL {
        var url = baseUrl.appendingPathComponent(endpoint.pathComponent)
        switch endpoint {
        case .currentWeather(let lat, let lon), .forecast(let lat, let lon):
            url.append(queryItems: [URLQueryItem(name: "lat",
                                                 value: String(lat)),
                                    URLQueryItem(name: "lon",
                                                 value: String(lon))])
        case .forecastId(let id), .currentWeatherId(let id):
            url.append(queryItems: [URLQueryItem(name: "id",
                                                 value: String(id))])
        case .group(let ids):
            url.append(queryItems:
                        [URLQueryItem(name: "id",
                                      value: ids.map { String($0) }
                            .joined(separator: ","))])
        }
        url.append(queryItems: [
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appID", value: appID),
            URLQueryItem(name: "lang", value: "ru")
        ])
        return url
    }
}
