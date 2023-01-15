//
//  Reusable.swift
//  Bemily
//
//  Created by ByungHoon Ann on 2023/01/11.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
