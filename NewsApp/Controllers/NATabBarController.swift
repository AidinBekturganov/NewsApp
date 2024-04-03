//
//  ViewController.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import UIKit

final class NATabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpTabs()
    }
    
    private func setUpTabs() {
        let articleVC = NAArticleViewController()
        let favoriteArticlesVC = NAFavoriteArticlesViewController()
        
        articleVC.navigationItem.largeTitleDisplayMode = .automatic
        favoriteArticlesVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: articleVC)
        let nav2 = UINavigationController(rootViewController: favoriteArticlesVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Article",
                                       image: UIImage(systemName: "newspaper"),
                                       tag: 1)
        
        nav2.tabBarItem = UITabBarItem(title: "Favorites",
                                       image: UIImage(systemName: "star"),
                                       tag: 2)
        
        for nav in [nav1, nav2] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [nav1, nav2],
            animated: true)
    }
}

