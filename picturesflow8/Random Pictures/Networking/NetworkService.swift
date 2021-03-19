//
//  NetworkService.swift
//  picturesflow8
//
//  Created by Егор Горских on 18.03.2021.
//

import Foundation

final class NetworkService {
    
    func request(completion: @escaping (Data?, Error?) -> Void) {
        
        let paramenters = self.prepareParamenters()
        let url = self.url(params: paramenters)
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = prepareHeader()
        urlRequest.httpMethod = "get"
        let task = createDataTask(from: urlRequest, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID eRBTYrBoLVAZ-sfZUGfeqsfpVa8SkWoQPNUQRyYOFGo"
        return headers
    }
    
    private func prepareParamenters() -> [String: String] {
        var parameters = [String: String]()
        parameters["count"] = String(30)
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos/random"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest,
                                completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
