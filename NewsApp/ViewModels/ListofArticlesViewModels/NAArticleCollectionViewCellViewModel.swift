//
//  NAArticleCollectionViewCellViewModel.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import Foundation

final class NAArticleCollectionViewCellViewModel: Hashable, Equatable {
    public let authorName: String
    public let releaseDate: String
    public let titleOfArticle: String
    public let articleImageUrl: URL?
    
    // MARK: - Init
    
    init(
        authorName: String,
        titleOfArticle: String,
        releaseDate: String,
        articleImageUrl: URL?
    ) {
        self.authorName = authorName
        self.titleOfArticle = titleOfArticle
        self.releaseDate = releaseDate
        self.articleImageUrl = articleImageUrl
    }
    
    // MARK: - Hashable
    
    static func == (lhs: NAArticleCollectionViewCellViewModel, rhs: NAArticleCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(authorName)
        hasher.combine(titleOfArticle)
        hasher.combine(releaseDate)
        hasher.combine(articleImageUrl)
    }
}
