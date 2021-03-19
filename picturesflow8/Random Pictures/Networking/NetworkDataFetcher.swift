//
//  NetworkDataFetcher.swift
//  picturesflow8
//
//  Created by Егор Горских on 18.03.2021.
//

import Foundation

final class NetworkDataFetcher {

    var networkService = NetworkService()
    
    func fetchImage(completion: @escaping ([RandomPicturesResponse]) -> ()) {

        networkService.request() { (data, error) in
            
            let decode = self.decodeJSON(type: [RandomPicturesResponse].self, from: data)
            guard let decoded = decode else {return}
            completion(decoded)
            
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
            }

            
        }
    }
    
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
