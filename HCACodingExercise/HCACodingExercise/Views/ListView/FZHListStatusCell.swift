//
//  FZHListStatusCell.swift
//  HCACodingExercise
//
//  Created by Forest Horvath on 1/20/25.
//

import Foundation
import UIKit

class FZHListStatusCell: UITableViewCell {
    
    var titleLabel = UILabel()
    var loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        self.createViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createViews() {
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        loadingIndicator.hidesWhenStopped = true
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(loadingIndicator)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            loadingIndicator.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            loadingIndicator.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.centerYAnchor),
            loadingIndicator.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            loadingIndicator.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant:-10.0),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 30.0),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10.0)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func setLoading() {
        titleLabel.text = "Loading..."
        titleLabel.textColor = .systemGray
        loadingIndicator.startAnimating()
        self.selectionStyle = .none
    }
    
    
    func setError() {
        titleLabel.text = "Something went wrong"
        titleLabel.textColor = .systemRed
        loadingIndicator.stopAnimating()
        self.selectionStyle = .gray
    }
}
