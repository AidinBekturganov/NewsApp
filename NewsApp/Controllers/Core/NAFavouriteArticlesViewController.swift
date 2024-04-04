//
//  NAFavoriteArticlesViewController.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import UIKit

/// Controller to show Favorites
final class NAFavouriteArticlesViewController: UIViewController, NAFavouriteListViewDelegate {
    
    private let favouriteArticleListView = NAFavouriteListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Favourites"
        setUpView()
    }
    
    private func setUpView() {
        favouriteArticleListView.delegate = self
        view.addSubview(favouriteArticleListView)
        NSLayoutConstraint.activate([
            favouriteArticleListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favouriteArticleListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            favouriteArticleListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            favouriteArticleListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - NAFavouriteListViewDelegate
    
    func naFavouriteListView(_ articleListView: NAFavouriteListView, didSelectArticle article: Article) {
        let viewModel = NAFavouriteArticlesDetailViewViewModel(article: article)
        let detailVC = NAFavouriteArticlesDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
