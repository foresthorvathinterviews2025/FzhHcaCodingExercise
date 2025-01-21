//
//  FZHApiListViewModelMockProvider.swift
//  HCACodingExerciseTests
//
//  Created by Forest Horvath on 1/21/25.
//

import Foundation

enum FZHApiListViewModelMockProviderState {
    case priorToFirstResponse
    case priorToSecondResponse
    case onePage
    case twoPage
    case firstError
    case secondError
}

class FZHApiListViewModelMockProvider: FZHApiServiceProtocol, FZHApiListViewProtocol {
    
    var state = FZHApiListViewModelMockProviderState.twoPage
    
    var calledReload = false
    func reloadData() {
        calledReload = true
    }
    
    var calledDisplayError = false
    func display(error: any Error) {
        calledDisplayError = true
    }
    
    var calledSelectedLanguage = false
    func selected(languange: String?) {
        calledSelectedLanguage = true
    }
    
    let nextURL = URL(string:"http://www.google.com")
        
    func getApis(for user: String, success: @escaping ([FZHApi], URL?) -> Void, failure: @escaping (any Error) -> Void) {
        switch state {
        case .priorToFirstResponse:
            print("do nothing")
        case .priorToSecondResponse:
            success(pageOneData,nextURL)
        case .onePage:
            success(pageOneData,nil)
        case .twoPage:
            success(pageOneData,nextURL)
        case .firstError:
            failure(FZHError.parseError)
        case .secondError:
            success(pageOneData,nextURL)
        }
    }
    
    func getApis(for url: URL, success: @escaping ([FZHApi], URL?) -> Void, failure: @escaping (any Error) -> Void) {
        
            switch state {
            case .priorToFirstResponse:
                print("do nothing")
            case .priorToSecondResponse:
                print("do nothing")
            case .onePage:
                print("do nothing")
            case .twoPage:
                success(pageTwoData,nil)
            case .firstError:
                print("do nothing")
            case .secondError:
                failure(FZHError.parseError)
            }
    }
    
}

extension FZHApiListViewModelMockProvider {
    
    var pageOneData: [FZHApi] {
        guard let placeholderURL = URL(string:"http://www.google.com") else {
            return []
        }
        return [
            FZHApi(id:1, name:"FirstAPI",
                   htmlURL: placeholderURL,
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000"),
            FZHApi(id:2, name:"Second API",
                   htmlURL: placeholderURL,
                   description: "This is what the API does. I am making this a long description because it seems like a good test case. Lorem Ipsum Dolor Sot Amet.",
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000",
                   language:"C"),
            FZHApi(id:3, name:"The Third API",
                   htmlURL: placeholderURL,
                   description: "This is what the API does. I am making this a long description because it seems like a good test case. Lorem Ipsum Dolor Sot Amet.",
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000",
                   language:"C"),
            FZHApi(id:4, name:"Fourth API",
                   htmlURL: placeholderURL,
                   description: "This is what the API does. I am making this a long description because it seems like a good test case. Lorem Ipsum Dolor Sot Amet.",
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000",
                   language:"C"),
            FZHApi(id:5, name:"Fifth API",
                   htmlURL: placeholderURL,
                   description: "This is what the API does. I am making this a long description because it seems like a good test case. Lorem Ipsum Dolor Sot Amet.",
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000",
                   language:"C"),
            FZHApi(id:6, name:"Sixth API",
                   htmlURL: placeholderURL,
                   description: "This is what the API does. I am making this a long description because it seems like a good test case. Lorem Ipsum Dolor Sot Amet.",
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000",
                   language:"C++"),
            FZHApi(id:7, name:"Seventh API",
                   htmlURL: placeholderURL,
                   description: "This is what the API does. I am making this a long description because it seems like a good test case. Lorem Ipsum Dolor Sot Amet.",
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000",
                   language:"C#"),
            FZHApi(id:8, name:"Eighth API",
                   htmlURL: placeholderURL,
                   description: "This is what the API does. I am making this a long description because it seems like a good test case. Lorem Ipsum Dolor Sot Amet.",
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000",
                   language:"Kotlin"),
            FZHApi(id:9, name:"Ninth API",
                   htmlURL: placeholderURL,
                   description: "This is what the API does. I am making this a long description because it seems like a good test case. Lorem Ipsum Dolor Sot Amet.",
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000",
                   language:"Kotlin"),
            FZHApi(id:10, name:"Tenth API",
                   htmlURL: placeholderURL,
                   description: "This is what the API does. I am making this a long description because it seems like a good test case. Lorem Ipsum Dolor Sot Amet.",
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000",
                   language:"C++")
            
        ]
    }
    
    var pageTwoData: [FZHApi] {
        guard let placeholderURL = URL(string:"http://www.google.com") else {
            return []
        }
        return [
            FZHApi(id:11, name:"The Eleventh API",
                   htmlURL: placeholderURL,
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000"),
            FZHApi(id:12, name:"Twelfth API",
                   htmlURL: placeholderURL,
                   description: "This is what the API does. I am making this a long description because it seems like a good test case. Lorem Ipsum Dolor Sot Amet.",
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000",
                   language:"Objective-C"),
            FZHApi(id:13, name:"Thirteent API",
                   htmlURL: placeholderURL,
                   description: "This is what the API does. I am making this a long description because it seems like a good test case. Lorem Ipsum Dolor Sot Amet.",
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000",
                   language:"Go"),
            FZHApi(id:14, name:"Fourteenth API",
                   htmlURL: placeholderURL,
                   description: "This is what the API does. I am making this a long description because it seems like a good test case. Lorem Ipsum Dolor Sot Amet.",
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000",
                   language:"C"),
            FZHApi(id:15, name:"Fifteenth API",
                   htmlURL: placeholderURL,
                   description: "This is what the API does. I am making this a long description because it seems like a good test case. Lorem Ipsum Dolor Sot Amet.",
                   creationDateString: "2018-08-18T00:00:00+1000",
                   updatedDateString: "2018-08-18T00:00:00+1000",
                   pushDateString: "2018-08-18T00:00:00+1000",
                   language:"Go")
        ]
    }
}
