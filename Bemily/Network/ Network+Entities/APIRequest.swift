//
//  APIRequest.swift
//  Bemily
//
//  Created by ByungHoon Ann on 2023/01/10.
//
import Foundation

protocol APIRequest {
    var baseURLString: String { get }
    var urlString: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String : String]? { get }
    var headers: [String: String]? { get }
}

extension APIRequest {
    var baseURLString: String {
        return "https://itunes.apple.com/kr"
    }
    
    var urlString: String {
        return baseURLString
    }
    
    var path: String {
        return ""
    }

    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : String]? {
        return nil
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
