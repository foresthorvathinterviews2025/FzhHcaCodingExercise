//
//  FZHApiListViewModel.swift
//  HCACodingExercise
//
//  Created by Forest Horvath on 1/19/25.
//

import Foundation

protocol FZHApiListViewProtocol: AnyObject {
    func reloadData()
    func display(error:Error)
    func selected(languange:String?)
}

class FZHApiListViewModel {
    
    var madeCall = false
    var fetching = false
    var hasError = false
    
    var username = "goggle"
    
    var apiList: [FZHApi] = []
    
    var languageFilter: String?
    
    var filteredList: [FZHApi] {
        if languageFilter == nil {
            return apiList
        }
        return apiList.filter {
            $0.language == languageFilter
        }
    }
    
    var languages: [String] = []
    
    var nextPage: URL? = nil
    
    var loading: Bool {
        return (!madeCall || nextPage != nil)
    }
    
    var apiService: FZHApiServiceProtocol
    weak var view: (FZHApiListViewProtocol)?
    
    init(apiService: FZHApiServiceProtocol, view:FZHApiListViewProtocol? = nil) {
        self.apiService = apiService
        self.view = view
    }
    
    func getData() {
        if fetching {
            return
        }
        madeCall = true
        fetching = true
        if let nextPage = nextPage {
            weak var weakself = self
            apiService.getApis(for:nextPage) { apis, nextPage in
                weakself?.fetching = false
                weakself?.addLanguages(from:apis)
                weakself?.recieved(apis: apis, nextPage: nextPage)
            } failure: { error in
                weakself?.fetching = false
                weakself?.hasError = true
                weakself?.view?.display(error:error)
            }

        } else {
            weak var weakself = self
            apiService.getApis(for:username) { apis, nextPage in
                weakself?.fetching = false
                weakself?.addLanguages(from:apis)
                weakself?.recieved(apis: apis, nextPage: nextPage)
            } failure: { error in
                weakself?.fetching = false
                weakself?.hasError = true
                weakself?.view?.display(error:error)
            }
        }
    }
    
    private func addLanguages(from newApis:[FZHApi]) {
        for api in newApis {
            if let language = api.language {
                if !languages.contains(language) {
                    languages.append(language)
                }
            }
        }
    }
    
    private func recieved( apis:[FZHApi], nextPage:URL? ) {
        apiList.append(contentsOf: apis)
        self.nextPage = nextPage
        view?.reloadData()
    }
    
    func sections() -> Int {
        if loading || hasError {
            return 2
        }
        return 1
    }
    
    func apiRows() -> Int {
        return filteredList.count
    }
    
}
