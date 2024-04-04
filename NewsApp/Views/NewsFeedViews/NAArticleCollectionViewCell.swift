//
//  NAArticleCollectionViewCell.swift
//  NewsApp
//
//  Created by Aidin Bekturganov on 3/4/24.
//

import UIKit

class NAArticleCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "NAArticleCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "NoImage")
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, titleLabel, dateLabel)
        addConstraints()
        setUpLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -3, height: 3)
        contentView.layer.shadowOpacity = 0.2
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),

            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),

            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),


            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -3),
        ])
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(named: "NoImage")
        nameLabel.text = nil
        titleLabel.text = nil
        dateLabel.text = nil
    }

    public func configure(with viewModel: NAArticleCollectionViewCellViewModel) {
        nameLabel.text = viewModel.authorName
        titleLabel.text = viewModel.titleOfArticle
        dateLabel.text = viewModel.releaseDate
        imageView.sd_setImage(with: viewModel.articleImageUrl, placeholderImage: UIImage(named: "NoImage"))
    }
}
