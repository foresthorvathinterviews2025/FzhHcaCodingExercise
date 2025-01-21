//
//  FZHApiListViewController.swift
//  HCACodingExercise
//
//  Created by Forest Horvath on 1/19/25.
//

import Foundation
import UIKit

class FZHApiListViewController: UIViewController {
    
    
    let apiCellIdentifier = "apiCell"
    let loadingCellIdentifier = "loadingCell"
    
    let viewModel = FZHApiListViewModel(apiService:FZHNetworkApiService())
    
    var tableView: UITableView?
    
    var languageButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = viewModel.username
        
        viewModel.view = self
        
        view.backgroundColor = .systemBackground
        addTableView()
        makeLanguageButton()
    }
    
    func addTableView() {
        
        let newTableView = UITableView()
        newTableView.dataSource = self
        newTableView.delegate = self
        
        self.view.addSubview(newTableView)
        
        newTableView.translatesAutoresizingMaskIntoConstraints = false
        
        newTableView.register(FZHApiListCell.self, forCellReuseIdentifier:apiCellIdentifier)
        newTableView.register(FZHListStatusCell.self, forCellReuseIdentifier:loadingCellIdentifier)
        
        let constraints = [
            newTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            newTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            newTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            newTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
        
        
        self.tableView = newTableView
    }
    
    func makeLanguageButton() {
        languageButton = UIBarButtonItem(title:"Language", style: .plain, target: self, action:#selector(selectLanguageButtonAction))
        languageButton?.isEnabled = false
        self.navigationItem.rightBarButtonItem = languageButton
    }
    
    @objc func selectLanguageButtonAction() {
        let languageView = FZHLanguageViewController()
        languageView.languageList = viewModel.languages
        languageView.selectedLanguage = viewModel.languageFilter
        languageView.delegate = self
        
        self.navigationController?.pushViewController(languageView, animated:true)
    }
    
    func makeDetailsView(for index:Int) {
        let detailView = FZHDetailViewController()
        detailView.api = viewModel.apiList[index]
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

extension FZHApiListViewController: FZHApiListViewProtocol {
    func selected(languange: String?) {
        viewModel.languageFilter = languange
        self.reloadData()
        self.navigationController?.popToViewController(self, animated:true)
    }
    
    func reloadData() {
        tableView?.reloadData()
        if viewModel.languages.count > 0 {
            languageButton?.isEnabled = true
        }
    }
    
    func display(error: any Error) {
        
        self.reloadData()
        
        var alertBody = "Soemthing went wrong"
        
        if error.localizedDescription != "" {
            alertBody = error.localizedDescription
        }
        
        let alert = UIAlertController(title: "Error", message: alertBody, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension FZHApiListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.apiRows()
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier:apiCellIdentifier) as! FZHApiListCell
            cell.setContent(for:viewModel.filteredList[indexPath.row])
                return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier:loadingCellIdentifier) as! FZHListStatusCell
        if viewModel.hasError {
            cell.setError()
        } else {
            cell.setLoading()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1, !viewModel.hasError {
            self.viewModel.getData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at:indexPath, animated:true)
        
        if indexPath.section == 0 {
            self.makeDetailsView(for: indexPath.row)
        } else if viewModel.hasError {
            viewModel.hasError = false
            viewModel.getData()
        }
    }
}
