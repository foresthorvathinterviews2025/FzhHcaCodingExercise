//
//  FZHApiListCell.swift
//  HCACodingExercise
//
//  Created by Forest Horvath on 1/19/25.
//

import Foundation
import UIKit

class FZHApiListCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var languageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.createLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLabels() {
        
        
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        descriptionLabel.font = .preferredFont(forTextStyle: .caption2)
        descriptionLabel.textColor = .systemGray2
        languageLabel.font = .preferredFont(forTextStyle:.body)
        languageLabel.textColor = .systemGray
        
        descriptionLabel.numberOfLines = 0
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(languageLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant:10.0),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant:10.0),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:10.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
            languageLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            languageLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10.0),
            languageLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant:-10.0),
            descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant:-10.0),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10.0)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func setContent(for api:FZHApi) {
        self.titleLabel.text = api.name
        self.descriptionLabel.text = api.description
        self.languageLabel.text = api.language
    }
}
