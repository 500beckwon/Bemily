//
//  UIImageView+Extension.swift
//  Bemily
//
//  Created by ByungHoon Ann on 2023/01/11.
//

import UIKit

extension UIImageView {
    func setImageUrl(_ imageName: String) {
        ImageDownLoader
            .shared
            .setImage(to: self,
                      imageURLString: imageName)
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: { [weak self] in
            self?.image = image
        })
    }
}
