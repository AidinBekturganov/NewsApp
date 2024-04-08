//
//  NAFavouriteArticlesDetailViewController.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 8/4/24.
//

import UIKit

/// Controller to show info about single article (news)
final class NAFavouriteArticlesDetailViewController: UIViewController {
    private let viewModel: NAFavouriteArticlesDetailViewViewModel
    
    private let detailView: NAFavouriteArticlesDetailView
    
    init(viewModel: NAFavouriteArticlesDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = NAFavouriteArticlesDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(detailView)
        
        addConstraints()
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
