//
//  NAArticleDetailViewViewModel.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import Foundation

final class NAArticleDetailViewViewModel {
    public let article: NAArticle
    public let imageURL: URL?

    init(article: NAArticle) {
        self.article = article
        self.imageURL = URL(string: article.imageURL ?? "")
    }
    
    func saveArticle(publicationDate: String, title: String, desc: String, imageURL: String) {
        CoreDataManager.shared.addArticle(publicationDate: publicationDate, title: title, desc: desc, imageURL: imageURL)
        NotificationCenter.default.post(name: .myNotification, object: nil)
    }
}
