//
//  UIColletionView+Extension.swift
//  Bemily
//
//  Created by ByungHoon Ann on 2023/01/11.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_: T.Type) {
        register(T.self,
                 forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Unable to dequeue Reusable UICollectionViewCell")
        }
        return cell
    }
}
