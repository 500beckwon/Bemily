//
//  PreviewBemilyCollectionCell.swift
//  Bemily
//
//  Created by ByungHoon Ann on 2023/01/10.
//

import UIKit
import SnapKit

final class PreviewBemilyCollectionCell: UICollectionViewCell {
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        insertUI()
        basicSetUI()
        anchorUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configureCell(info: String) {
        imageView.setImageUrl(info)
    }
}

private extension PreviewBemilyCollectionCell {
    func insertUI() {
        contentView.addSubview(imageView)
    }
    
    func basicSetUI() {
        contentView.backgroundColor = .systemBackground
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
    }
    
    func anchorUI() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
