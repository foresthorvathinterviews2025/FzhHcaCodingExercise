//
//  FZHApi.swift
//  HCACodingExercise
//
//  Created by Forest Horvath on 1/19/25.
//

import Foundation

struct FZHApi: Codable {
    var id: Int
    var name: String
    
    var htmlURL: URL
    var description: String?
    var creationDateString: String
    var updatedDateString: String
    var pushDateString: String
    var language: String?
    
    var creationDate: Date? {
        return ISO8601DateFormatter().date(from:creationDateString)
    }
    var updatedDate: Date? {
        return ISO8601DateFormatter().date(from:updatedDateString)
    }
    var pushDate: Date? {
        return ISO8601DateFormatter().date(from:pushDateString)
    }
    
    enum CodingKeys: String, CodingKey {
        case htmlURL = "html_url"
        case creationDateString = "created_at"
        case updatedDateString = "updated_at"
        case pushDateString = "pushed_at"
        
        case id
        case name
        case description
        case language
    }
}
