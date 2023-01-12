//
//  ImageDownLoader.swift
//  Bemily
//
//  Created by ByungHoon Ann on 2023/01/10.
//

import UIKit

final class ImageDownLoader {
    
    static let shared = ImageDownLoader()
    
    func setImage(to imageView: UIImageView, imageURLString: String) {
        if let cachedImage = ImageCache.shared.imageObject(imageName: imageURLString) {
            imageView.image = cachedImage
            return
        }
        
        AppInfoRequest
            .requestAppScreenShotImage(imageURLString: imageURLString) { result in
                switch result {
                case .success(let imageData):
                    DispatchQueue.main.async {
                        if let image = UIImage(data: imageData) {
                            
                            ImageCache
                                .shared
                                .setDiskCache(imageName: imageURLString,
                                              imageData: imageData)
                            
                            imageView.transition(toImage: image)
                        }
                    }
                case .failure(let failure):
                    print("image Download Failure = \(failure.localizedDescription)")
                }
            }
    }
}
