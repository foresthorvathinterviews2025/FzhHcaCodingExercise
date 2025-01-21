//
//  FZHApiServiceProtocol.swift
//  HCACodingExercise
//
//  Created by Forest Horvath on 1/19/25.
//

import Foundation

protocol FZHApiServiceProtocol {
    func getApis(for user:String, success: @escaping ([FZHApi], URL?) -> Void, failure: @escaping (Error) -> Void)
    func getApis(for url: URL, success: @escaping ([FZHApi], URL?) -> Void, failure: @escaping (Error) -> Void)
}
