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
    
    
    /// Send API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: NARequest,
        expecting type: T.Type,
        completion: @escaping () -> Void
    ) {
         
    }
}
