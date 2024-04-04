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

    init(viewModel: NAArticleDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }

}
