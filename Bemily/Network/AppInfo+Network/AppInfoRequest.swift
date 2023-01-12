//
//  AppInfoRequest.swift
//  Bemily
//
//  Created by ByungHoon Ann on 2023/01/11.
//

import Foundation

final class AppInfoRequest {
    static func requestAppInfo(id: String ,completion: @escaping((Result<AppInfo, Error>) -> Void)) {
        NetworkRequest(apiRequest: AppInfoAPI.lookup(id: id))
            .requestFetch(completion: completion)
    }
    
    static func requestAppScreenShotImage(imageURLString: String, completion: @escaping((Result<Data, Error>) -> Void)) {
        NetworkRequest<Data>(apiRequest: AppInfoAPI.imageDownload(urlString: imageURLString))
            .requestImage(completion: completion)
    }
}
