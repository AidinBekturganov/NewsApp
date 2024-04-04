//
//  ArticleListViewViewModel.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import UIKit

protocol NAArticleListViewViewModelDelegate: AnyObject {
    func didLoadInitialArticles()
    func didLoadMoreArticles(with newIndexPaths: [IndexPath])
    func didSelectArticle(_ article: NAArticle)
}

final class NAArticleListViewViewModel : NSObject {
    
    public weak var delegate: NAArticleListViewViewModelDelegate?
    
    private var isLoadingMoreArticles = false
    
    private var cellViewModels: [NAArticleCollectionViewCellViewModel] = []
    private var apiInfo: NAGetAllArticlesResponse? = nil
    
    private var articles: [NAArticle] = [] {
        didSet {
            
            for article in articles {
                let viewModel = NAArticleCollectionViewCellViewModel(
                    authorName: (article.creator ?? ["Unknown"]).joined(separator: ", "),
                    titleOfArticle: article.title,
                    releaseDate: article.pubDate ?? Date.now.formatted(),
                    articleImageUrl: URL(string: article.imageURL ?? ""))
                
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    public func fetchArticles() {
        NAService.shared.execute(.listArticlesRequests, expecting: NAGetAllArticlesResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.articles = results
                self?.apiInfo = responseModel
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialArticles()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchAdditionalArticles(nextPageQueryItem: String) {
        
        guard !isLoadingMoreArticles else {
            return
        }
        
        isLoadingMoreArticles = true
        guard let request = NARequest(nextPageItem: nextPageQueryItem) else {
            isLoadingMoreArticles = false
            return
        }
        
        NAService.shared.execute(request, expecting: NAGetAllArticlesResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                strongSelf.apiInfo = responseModel
                
                let originalCount = strongSelf.articles.count
                let newCount = moreResults.count
                let total = originalCount+newCount
                let startigIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(startigIndex..<(startigIndex+newCount)).compactMap ({
                    return IndexPath(row: $0, section: 0)
                })
                
                
                strongSelf.articles.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreArticles(with: indexPathsToAdd)
                    strongSelf.isLoadingMoreArticles = false
                    
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.nextPage != nil
    }
}

extension NAArticleListViewViewModel : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NAArticleCollectionViewCell.cellIdentifier, for: indexPath) as? NAArticleCollectionViewCell else {
            fatalError("Unsuported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NAFooterLoadingCollectionReusableView.identifier, for: indexPath) as? NAFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        
        footer.startAnimating()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        
        return CGSize(width: collectionView.frame.width, height: 100)
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

extension NAArticleListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreArticles,
              !cellViewModels.isEmpty,
              let nextPageQueryItem = apiInfo?.nextPage
        else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalArticles(nextPageQueryItem: nextPageQueryItem)
            }
            t.invalidate()
        }
    }
}


