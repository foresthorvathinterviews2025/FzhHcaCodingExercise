//
//  FZHLanguageViewController.swift
//  HCACodingExercise
//
//  Created by Forest Horvath on 1/19/25.
//

import Foundation
import UIKit

class FZHLanguageViewController: UIViewController {
    let languageCellIdentifier = "languageCell"
    
    var languageList: [String]?
    var selectedLanguage: String?
    weak var delegate: (FZHApiListViewProtocol)?
    
    
    var tableView: UITableView?
    
    var useMock = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        addTableView()
    }
    
    func addTableView() {
        
        let newTableView = UITableView()
        newTableView.dataSource = self
        newTableView.delegate = self
        
        self.view.addSubview(newTableView)
        
        newTableView.translatesAutoresizingMaskIntoConstraints = false
        
        newTableView.register(UITableViewCell.self, forCellReuseIdentifier:languageCellIdentifier)
        
        let constraints = [
            newTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            newTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            newTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
        
        
        self.tableView = newTableView
    }
}


extension FZHLanguageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return languageList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:languageCellIdentifier)!
        
        var content = cell.defaultContentConfiguration()
        
        if indexPath.section == 0 {
            content.text = "No Filter"
            content.textProperties.color = .systemRed
            if selectedLanguage == nil {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        } else if let language = languageList?[indexPath.row] {
            content.text = language
            content.textProperties.color = .black
            
            if selectedLanguage == language {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var rowSelected: String? = nil
        
        if indexPath.section == 1 {
            rowSelected = languageList?[indexPath.row]
        }
        
        delegate?.selected(languange:rowSelected)
    }
    
}
