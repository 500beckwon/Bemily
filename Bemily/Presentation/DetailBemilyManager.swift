//
//  DetailBemilyManager.swift
//  Bemily
//
//  Created by ByungHoon Ann on 2023/01/11.
//

import Foundation

final class DetailBemilyManager {
    private var screenShotList = [String]()
    private var currentIndex = 0
    
    func requestFetchDetailBemily(id: String,
                                  completion: @escaping(_ screenshot: String?) -> Void) {
        AppInfoRequest.requestAppInfo(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.screenShotList = success.screenshotList
                self.currentIndex += 1
                completion(success.screenshotList.first)
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func nextScreenShot() -> String? {
        guard screenShotList.count > currentIndex else { return nil }
        let screenShot = screenShotList[currentIndex]
        currentIndex += 1
        return screenShot
    }
}
