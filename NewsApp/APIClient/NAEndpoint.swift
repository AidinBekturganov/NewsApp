//
//  NAEndpoint.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import Foundation


/// Represents unique API endpoint
@frozen enum NAEndpoint: String {
    /// Endpoint to get article info
    case article
    /// Endpoint to get favorites info
    case favorites
}

