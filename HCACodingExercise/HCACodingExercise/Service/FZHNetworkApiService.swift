//
//  FZHNetworkApiService.swift
//  HCACodingExercise
//
//  Created by Forest Horvath on 1/19/25.
//

import Foundation

class FZHNetworkApiService: FZHApiServiceProtocol {
    
    func getApis(for user:String = "google", success: @escaping ([FZHApi], URL?) -> Void, failure: @escaping (Error) -> Void) {
        
        do {
            try self.test(username: user)
        } catch {
            failure(FZHError.invalidUser)
            return
        }
        
        let urlString = "https://api.github.com/users/\(user)/repos"
        
        guard let url = URL(string: urlString) else {
            failure(FZHError.invalidURL)
            return
        }
        
        self.getApis(for:url, success: success, failure: failure)
    }
    
    func getApis(for url: URL, success: @escaping ([FZHApi], URL?) -> Void, failure: @escaping (Error) -> Void) {
                var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        print(url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            let nextPage = try? self.parseNextPage(from:response)

            if let data = data {
                
                   do {
                       let results = try JSONDecoder().decode([FZHApi].self, from: data)
                       
                       DispatchQueue.main.async {
                           success(results, nextPage)
                       }
                   } catch {
                       
                       DispatchQueue.main.async {
                           failure(FZHError.parseError)
                       }
                   }
            }
        }.resume()
    }
    
    
    
    func test(username:String) throws {
        let validUsername  = try Regex("^([A-z\\-0-9])+$")
        if !username.contains(validUsername) {
            throw FZHError.invalidUser
        }
    }
    
    func parseNextPage(from response:URLResponse?) throws -> URL? {
        
        guard let  response = response as? HTTPURLResponse,
              let link = response.value(forHTTPHeaderField:"link") else {
            return nil
        }
        
        let nextPageRegEx = try Regex("<.*>; rel=\"next\"")
        guard let range = link.firstRange(of:nextPageRegEx) else {
            return nil
        }
        var substring = String(link[range])
        substring = substring.replacing("<", with:"")
        substring = substring.replacing(">; rel=\"next\"", with:"")
        
        if let url = URL(string: substring) {
            return url
        }
        return nil
    }
        
}
