//
//  ArticleListView.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import UIKit
protocol NAArticleListViewDelegate: AnyObject {
    func naArticleListView(_ articleListView: NAArticleListView, didSelectArticle article: NAArticle)
}

/// View that handles showing list of articles, loader etc.
final class NAArticleListView: UIView {
    
    public weak var delegate: NAArticleListViewDelegate?
    
    private let viewModel = NAArticleListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NAArticleCollectionViewCell.self, forCellWithReuseIdentifier: NAArticleCollectionViewCell.cellIdentifier)
        
        collectionView.register(NAFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: NAFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(spinner, collectionView)
        
        addConstraints()
        
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchArticles()
        
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
}

extension NAArticleListView: NAArticleListViewViewModelDelegate {
    func didLoadMoreArticles(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
    
    func didSelectArticle(_ article: NAArticle) {
        delegate?.naArticleListView(self, didSelectArticle: article)
    }
    
    func didLoadInitialArticles() {
        spinner.stopAnimating()
        
        collectionView.isHidden = false
        collectionView.reloadData()

        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
}
