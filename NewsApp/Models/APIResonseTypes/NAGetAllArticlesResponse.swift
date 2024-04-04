//
//  NAGetAllArticlesResponse.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import Foundation

struct NAGetAllArticlesResponse: Codable {
    let status: String
    let totalResults: Int
    let nextPage: String
    let results: [NAArticle]
}
