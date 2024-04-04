//
//  NAFavouriteArticlesCellViewViewModel.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 4/4/24.
//

import Foundation

final class NAFavouriteArticlesCellViewViewModel: Hashable, Equatable {
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
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = articleImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        NAImageLoader.shared.downloadImage(url, completion: completion)
    }
    
    // MARK: - Hashable
    
    static func == (lhs: NAFavouriteArticlesCellViewViewModel, rhs: NAFavouriteArticlesCellViewViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(authorName)
        hasher.combine(titleOfArticle)
        hasher.combine(releaseDate)
        hasher.combine(articleImageUrl)
    }
}
