//
//  Decoders.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/14/24.
//

import Foundation

enum AppError: Error, Decodable {
    case connectivityError
    case decodeJSONfailed
    case apiError(APIError)
    case networkError
    case other(_ error: String? = nil)
    
    case unknown
    
    var description: String {
        switch self {
        case .connectivityError: return "Connectivity Error"
        case .decodeJSONfailed: return "Decode JSON failed"
        case .apiError(let apiError): return apiError.message
        case .networkError: return "Network Error"
        case .other(let error): return error ?? "Unknown Error"
        case .unknown: return "Unknown Error"
        }
    }
}

final class APIDataProvider {
    private let endpointProvider = APIEndpointProvider(for: .config)
    
    func getData<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (T) -> Void?,
                               errorHandler: @escaping (AppError) -> Void?) {
        let url = endpointProvider.getURL(for: endpoint)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                errorHandler(.connectivityError)
            } else {
                guard let data,
                      let statusCode = (response as? HTTPURLResponse)?.statusCode
                else {
                    errorHandler(.networkError)
                    return
                }
                
                if (200...299) ~= statusCode {
                    let decoder = JSONDecoder()
                    do {
                        let currentWeather = try decoder.decode(T.self, from: data)
                        completion(currentWeather)
                    } catch {
                        errorHandler(.decodeJSONfailed)
                    }
                } else {
                    do {
                        let error = try JSONDecoder().decode(APIError.self, from: data)
                        errorHandler(.apiError(error))
                    } catch {
                        errorHandler(.unknown)
                    }
                }
            }
        }.resume()
    }
}
