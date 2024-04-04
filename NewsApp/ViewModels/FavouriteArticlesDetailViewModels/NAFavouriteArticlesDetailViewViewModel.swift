//
//  NAFavouriteArticlesDetailViewViewModel.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 4/4/24.
//

import Foundation

final class NAFavouriteArticlesDetailViewViewModel {
    public let article: Article
    public let imageURL: URL?

    init(article: Article) {
        self.article = article
        self.imageURL = URL(string: article.imageURL ?? "")
    }
}
