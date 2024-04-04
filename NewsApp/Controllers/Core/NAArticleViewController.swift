//
//  NAArticleViewController.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import UIKit

/// Controller to show Articles
final class NAArticleViewController: UIViewController, NAArticleListViewDelegate {
  

    private let articleListView = NAArticleListView()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "News"        
        setUpView()
    }
    
    private func setUpView() {
        articleListView.delegate = self
        view.addSubview(articleListView)
        NSLayoutConstraint.activate([
            articleListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            articleListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            articleListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            articleListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: - NAArticleListViewDelegate
    
    func naArticleListView(_ articleListView: NAArticleListView, didSelectArticle article: NAArticle) {
        let viewModel = NAArticleDetailViewViewModel(article: article)
        let detailVC = NAArticleDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
