//
//  AppInfo.swift
//  Bemily
//
//  Created by ByungHoon Ann on 2023/01/10.
//

import Foundation

struct AppInfo: Codable {
    let screenshotList: [String]
    
    struct AppDetail: Codable {
        let screenshotUrls: [String]
    }
    
    enum CodingKeys: String, CodingKey {
        case screenshotList = "results"
    }
}

extension AppInfo {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let appDetail = try? container.decode([AppDetail].self,
                                                    forKey: .screenshotList),
              let screenShotUrls = appDetail.first?.screenshotUrls else {
            self.screenshotList = []
            return
        }
        self.screenshotList = screenShotUrls
    }
}
