//
//  AppInfoAPI.swift
//  Bemily
//
//  Created by ByungHoon Ann on 2023/01/11.
//

import Foundation

enum AppInfoAPI {
    case lookup(id: String)
    case imageDownload(urlString: String)
}

extension AppInfoAPI: APIRequest {
    var urlString: String {
        switch self {
        case .lookup:
            return baseURLString
        case .imageDownload(let urlString):
            return urlString
        }
    }
   
    var path: String {
        switch self {
        case .lookup:
            return "/lookup"
        default:
            return ""
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .lookup(let id):
            return ["id": id]
        default:
            return nil
        }
    }
}
