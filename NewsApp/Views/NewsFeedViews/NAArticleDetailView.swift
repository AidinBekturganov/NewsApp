//
//  NAArticleDetailView.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import UIKit

final class NAArticleDetailView: UIView {
    
    private let viewModel: NAArticleDetailViewViewModel
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.textColor = .label
        tv.font = .systemFont(ofSize: 14, weight: .medium)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isEditable = false
        return tv
    }()
    
    init(frame: CGRect, viewModel: NAArticleDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        addSubviews(imageView, nameLabel, titleLabel, dateLabel, descriptionTextView)
        addConstraints()
        configureData()
    }
    
    private func configureData() {
        let article = viewModel.article
        
        nameLabel.text = "Published by: \((article.creator ?? ["Unknown"]).joined(separator: ", "))"
        titleLabel.text = article.title
        dateLabel.text = "Publication date: \(String(describing: (article.pubDate == nil ? "" : article.pubDate!.toDate(withFormat: "yyyy-MM-dd HH:mm:ss").dateToString())))"
        descriptionTextView.text = article.description
        imageView.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage(named: "NoImage"))
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 300),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 7),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -7),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -7),
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 7),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -7),
            
            //dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            
            descriptionTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor),
            descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -3),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            preconditionFailure("Take a look to your format")
        }
        return date
    }
}

extension Date {
    func dateToString(withFormat format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
}
