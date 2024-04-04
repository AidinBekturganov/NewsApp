//
//  NAFooterLoadingCollectionReusableView.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import UIKit

final class NAFooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "NAFooterLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(spinner)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Usupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
