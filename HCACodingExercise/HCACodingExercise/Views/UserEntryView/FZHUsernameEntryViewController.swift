//
//  FZHUsernameEntryViewController.swift
//  HCACodingExercise
//
//  Created by Forest Horvath on 1/21/25.
//

import Foundation
import UIKit

class FZHUsernameEntryViewController: UIViewController {
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "GitHub app"
        
        view.backgroundColor = .systemBackground
        
            let titleLabel = UILabel()
            titleLabel.font = .preferredFont(forTextStyle:.headline)
            titleLabel.text = "Enter a username to see GitHub Repos"
        titleLabel.textAlignment = .center
            view.addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(textField)
        textField.placeholder = "username"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        let button = UIButton(type:.system)
        
        button.setTitle("See Repos", for:.normal)
        button.addTarget(self, action:#selector(search), for: .touchUpInside)
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50.0),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant:-10.0),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0),
            textField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            textField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            textField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant:-10.0),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20.0),
            button.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant:-10.0)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func search() {
        if let text =  textField.text {
            let viewcontroller = FZHApiListViewController()
            viewcontroller.viewModel.username = text
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
    
    
}
