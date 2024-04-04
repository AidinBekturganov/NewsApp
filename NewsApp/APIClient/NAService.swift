//
//  NAService.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import Foundation


/// Primary API service to get Articles
final class NAService {
    
    /// Shared singleton instance
    static let shared = NAService()
    
    
    /// Privatized constructor
    private init() {}
    
    enum NAServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: NARequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(NAServiceError.failedToCreateRequest))
            return
        }
                
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NAServiceError.failedToGetData))
                return
            }
            
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - Private
    
    private func request(from naRequest: NARequest) -> URLRequest? {
        guard let url = naRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = naRequest.httpMethod
        return request
    }
}
