//
//  NAArticleDetailViewController.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import UIKit

/// Controller to show info about single article (news)
final class NAArticleDetailViewController: UIViewController {
    private let viewModel: NAArticleDetailViewViewModel
    
    private let detailView: NAArticleDetailView
    
    init(viewModel: NAArticleDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = NAArticleDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(detailView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .bookmarks,
            target: self,
            action: #selector(didTapSave)
        )
        addConstraints()
    }
    
    @objc
    private func didTapSave() {
        viewModel.saveArticle(publicationDate: viewModel.article.pubDate ?? "", title: viewModel.article.title, desc: viewModel.article.description ?? "", imageURL: viewModel.article.imageURL ?? "")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
