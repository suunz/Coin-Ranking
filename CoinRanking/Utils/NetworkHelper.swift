//
//  NetworkHelper.swift
//  CoinRanking
//
//  Created by Sanjay Tandukar on 2/20/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

class NetworkHelper {
    static let shared = NetworkHelper()
    private init() {}

    /// Generic GET Request
    func fetch<T: Decodable>(urlString: String, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        // Validate URL
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        // Create URL Request
        let request = URLRequest(url: url)

        // Perform Network Call
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle Error
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            // Validate Response
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode), let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            // Decode JSON
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }.resume()
    }
}

