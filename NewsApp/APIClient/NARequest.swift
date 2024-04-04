//
//  NARequest.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import Foundation


/// Object that represents a single API call
final class NARequest {
    
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://newsdata.io/api/1"
    }
    
    /// Desired endpoint
    private let endpoint: NAEndpoint
    
    /// Path components for API, if any
    private let pathComponents: [String]
    
    /// Query components for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Construction url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    
    //MARK: - Public
    
    /// Desired http method
    public let httpMethod = "GET"
    
    /// Construct reqeust
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of Path components
    ///   - queryParameters: Collection of query parameters
    public init(endpoint: NAEndpoint,
                pathComponents: [String] = [],
                queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(nextPageItem: String) {
        self.init(endpoint: .news,
                  queryParameters: [
                    URLQueryItem(name: "apiKey", value: "pub_41291bc59ac22bcbbc8b25cbe52bbea98e2e8"),
                    URLQueryItem(name: "category", value: "science"),
                    URLQueryItem(name: "language", value: "en,ru"),
                    URLQueryItem(name: "page", value: nextPageItem)
                  ])
    }
}

extension NARequest {
    static let listArticlesRequests = NARequest(
        endpoint: .news,
        queryParameters: [
            URLQueryItem(name: "apiKey", value: "pub_41291bc59ac22bcbbc8b25cbe52bbea98e2e8"),
            URLQueryItem(name: "category", value: "science"),
            URLQueryItem(name: "language", value: "en,ru")
        ])
}
