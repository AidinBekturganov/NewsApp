//
//  NASentimentStats.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import Foundation

/// SentimentStats model
struct NASentimentStats: Codable {
    let positive, neutral, negative: Double
}
