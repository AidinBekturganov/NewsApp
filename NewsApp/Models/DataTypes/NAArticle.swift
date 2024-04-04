//
//  NAArticle.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import Foundation

/// Article model
struct NAArticle: Codable {
    let articleID, title: String
    let link: String
    let keywords, creator: [String]?
    let videoURL: String?
    let description, content, pubDate: String?
    let imageURL: String?
    let sourceID: String?
    let sourceURL: String?
    let sourceIcon: String?
    let sourcePriority: Int
    let country, category: [String]
    let language: String
    let aiTag, aiRegion: String
    let sentiment: String
    let sentimentStats: String

    enum CodingKeys: String, CodingKey {
        case articleID = "article_id"
        case title, link, keywords, creator
        case videoURL = "video_url"
        case description, content, pubDate
        case imageURL = "image_url"
        case sourceID = "source_id"
        case sourceURL = "source_url"
        case sourceIcon = "source_icon"
        case sourcePriority = "source_priority"
        case country, category, language
        case aiTag = "ai_tag"
        case aiRegion = "ai_region"
        case sentiment
        case sentimentStats = "sentiment_stats"
    }
}
