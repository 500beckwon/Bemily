//
//  NetworkManager.swift
//  Bemily
//
//  Created by ByungHoon Ann on 2023/01/10.
//

import Foundation

final class NetworkManager {
    private let apiRequest: APIRequest
    let session: URLSession
    
    init(apiRequest: APIRequest, session: URLSession = URLSession.shared) {
        self.apiRequest = apiRequest
        self.session = session
    }
    
    func makeURL(_ apiRequest: APIRequest) -> URL? {
        var urlComponents = URLComponents(string: apiRequest.urlString)
        if let parameters = apiRequest.parameters {
            let query = parameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
            urlComponents?.queryItems = query
        }
        
        urlComponents?.path.append(apiRequest.path)
        return urlComponents?.url
    }
}
