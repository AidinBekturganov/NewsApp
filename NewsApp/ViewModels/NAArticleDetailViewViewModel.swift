//
//  NAArticleDetailViewViewModel.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import Foundation

final class NAArticleDetailViewViewModel {
    private let article: NAArticle
    
    init(article: NAArticle) {
        self.article = article
    }
    
    public var title: String {
        article.title.uppercased()
    }
}
