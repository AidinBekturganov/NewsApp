//
//  NAFavouriteArticlesListViewiewModel.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 4/4/24.
//

import Foundation
import UIKit

protocol NAFavouriteArticlesListViewViewModelDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
    func didLoadInitialArticles()
}

extension Notification.Name {
    static let myNotification = Notification.Name("MyNotification")
}

final class NAFavouriteArticlesListViewViewModel : NSObject {
    
    public weak var delegate: NAFavouriteArticlesListViewViewModelDelegate?
    
    
    private var cellViewModels: [NAFavouriteArticlesCellViewViewModel] = []
    private var apiInfo: NAGetAllArticlesResponse? = nil
    
    private var articles: [Article] = [] {
        didSet {
            for article in articles {
                let viewModel = NAFavouriteArticlesCellViewViewModel(
                    authorName: article.authorOfArticle ?? "Unknown",
                    titleOfArticle: article.title ?? "No title",
                    releaseDate: article.publicationDate ?? Date.now.formatted(),
                    articleImageUrl: URL(string: article.imageURL ?? ""))
                
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    func getAllArticles() {
        articles =  CoreDataManager.shared.getAllArticles()
        
        DispatchQueue.main.async {
            self.delegate?.didLoadInitialArticles()
        }
    }
    
    func refreshAllArticles() {
        articles =  CoreDataManager.shared.getAllArticles()
    }
    
    func saveArticle(publicationDate: String, title: String, desc: String, imageURL: String) {
        CoreDataManager.shared.addArticle(publicationDate: publicationDate, title: title, desc: desc, imageURL: imageURL)
        
        getAllArticles()
    }
    
    func deleteArticle(article: Article) {
        CoreDataManager.shared.deleteArticles(article: article)
        getAllArticles()
    }
}

extension NAFavouriteArticlesListViewViewModel : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAFavouriteArticleCollectionView.cellIdentifier, for: indexPath) as? NAFavouriteArticleCollectionView else {
            fatalError("Unsuported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)
        return CGSize(
            width: width,
            height: width
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let article = articles[indexPath.row]
        
        delegate?.didSelectArticle(article)
    }
}

