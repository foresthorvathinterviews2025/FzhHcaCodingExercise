//
//  FZHDetailViewController.swift
//  HCACodingExercise
//
//  Created by Forest Horvath on 1/20/25.
//

import Foundation

import UIKit

class FZHDetailViewController: UIViewController {
    var api: FZHApi?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        self.navigationItem.title = "Details"
        addContentsView()
    }
    
    func addContentsView() {
        let titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle:.largeTitle)
        titleLabel.text = api?.name
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant:10.0),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant:-10.0),
        ]
        
        var lastView: UIView = titleLabel
        
        if api?.htmlURL != nil {
            let newButton = UIButton(type:.system)
            newButton.setTitle("Visit in Browser", for:.normal)
            newButton.addTarget(self, action:#selector(visitLink), for: .touchUpInside)
            
            view.addSubview(newButton)
            newButton.translatesAutoresizingMaskIntoConstraints = false
            
            let buttonConstraints = [
                newButton.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant:10.0),
                newButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                newButton.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
                newButton.trailingAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant:-10.0),
            ]
            
            constraints.append(contentsOf: buttonConstraints)
        
            lastView = newButton
        }
        
        if let description = api?.description {
            let descriptionLabel = UILabel()
            descriptionLabel.font = .preferredFont(forTextStyle:.subheadline )
            descriptionLabel.text = description
            descriptionLabel.numberOfLines = 0
            descriptionLabel.textAlignment = .center
            view.addSubview(descriptionLabel)
            
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            
            
            let descriptionConstraints = [
                descriptionLabel.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant:10.0),
                descriptionLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                descriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
                descriptionLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant:-10.0),
            ]
            
            
            constraints.append(contentsOf: descriptionConstraints)
        
            lastView = descriptionLabel
        }
        
        let bodyLabel = UILabel()
        bodyLabel.font = .preferredFont(forTextStyle:.body )
        bodyLabel.text = constructBodyString()
        bodyLabel.numberOfLines = 0
        view.addSubview(bodyLabel)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let bodyConstraints = [
            bodyLabel.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant:10.0),
            bodyLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant:-10.0),
            bodyLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            bodyLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant:-10.0),
        ]
        
        constraints.append(contentsOf: bodyConstraints)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func visitLink() {
        if let apiUrl = api?.htmlURL {
            UIApplication.shared.open(apiUrl)
        }
    }
    
    func constructBodyString() -> String {
        var bodyString = ""
        
        guard let api = api else {
            return bodyString
        }
        
        if let apiLanguage = api.language {
            bodyString += "Language: \(apiLanguage)\n"
        }
        
        let dateFormat = DateFormatter()
        dateFormat.setLocalizedDateFormatFromTemplate("MM/dd/YYYY HH:mm")
        
        if let creationDate = api.creationDate {
            bodyString += "Created at: \(dateFormat.string(from: creationDate))\n"
        }
        if let updatedDate = api.updatedDate {
            bodyString += "Updated at: \(dateFormat.string(from: updatedDate))\n"
        }
        if let pushDate = api.pushDate {
            bodyString += "Pushed at: \(dateFormat.string(from: pushDate))\n"
        }
        
        return bodyString
    }
}
