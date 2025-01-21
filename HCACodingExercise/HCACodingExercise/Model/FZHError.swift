//
//  FZHError.swift
//  HCACodingExercise
//
//  Created by Forest Horvath on 1/19/25.
//

import Foundation

enum FZHError: Error {
    case invalidUser
    case invalidURL
    case parseError
}

extension FZHError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidUser:
            return NSLocalizedString("You have enterred an invalid username. Usernames are comprised only of alhpanumerics and hyphens.",
                                     comment:"description of an invalid undername")
        case .invalidURL:
            return NSLocalizedString("Something was wrong with the construction of the URL for this service call.",
                                     comment: "description of invalid URLS")
        case .parseError:
            return NSLocalizedString("Data could not be parsed. The data that came back on this service call was not formatted the expected way.",
                                     comment: "description of parsing error")
        }
    }
}
