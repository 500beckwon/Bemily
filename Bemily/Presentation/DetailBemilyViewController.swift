//
//  DetailBemilyViewController.swift
//  Bemily
//
//  Created by ByungHoon Ann on 2023/01/10.
//

import UIKit
import SnapKit

enum FailAlertType {
    case load
    case last
}

extension FailAlertType {
    var title: String {
        switch self {
        case .load:
            return "불러오기에 실패하였습니다."
        case .last:
            return "마지막 페이지입니다."
        }
    }
}

final class DetailBemilyViewController: UIViewController {
    let appID = "1502953604"
    
    private var previewButton = UIButton(type: .system)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cView = UICollectionView(frame: .zero,
                                     collectionViewLayout: layout)
        return cView
    }()
    
    let manager: DetailBemilyManager
    
    enum Section: CaseIterable {
        case main
    }
    
    private lazy var dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
        let cell: PreviewBemilyCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configureCell(info: itemIdentifier)
        return cell
    }
    
    init(manager: DetailBemilyManager = DetailBemilyManager()) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        insertUI()
        basicSetUI()
        anchorUI()
        fetch()
    }
}

private extension DetailBemilyViewController {
    func fetch() {
        manager
            .requestFetchDetailBemily(id: appID) { [weak self] screenShot in
                guard let self = self else { return }
                DispatchQueue
                    .main
                    .async {
                        guard let screenShot = screenShot else {
                            self.showFailAlert(type: .load)
                            return }
                        self.performQuery(item: screenShot)
                    }
            }
    }
    
    func performQuery(item: String?,
                      show isScroll: Bool = false) {
        guard let item = item else {
            showFailAlert(type: .last)
            return }
        
        dataSourceApply(item: item)
        
        if isScroll {
            scrollLastCollectionViewCell()
        }
    }
    
    func dataSourceApply(item: String) {
        var snapshot = dataSource.snapshot()
        if snapshot.sectionIdentifiers.isEmpty {
            snapshot.appendSections([.main])
        }
        
        snapshot.appendItems([item])
        dataSource.apply(snapshot,
                         animatingDifferences: true)
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { index, env in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .paging
            return section
        }
    }
}

private extension DetailBemilyViewController {
    @objc func previewButtonTapped(_ sender: UIButton) {
        let item = manager.nextScreenShot()
        performQuery(item: item,
                     show: true)
    }
}

private extension DetailBemilyViewController {
    func insertUI() {
        view.addSubview(collectionView)
    }
    
    func basicSetUI() {
        view.backgroundColor = .systemBackground
        
        previewButton.setTitle("미리보기", for: .normal)
        previewButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        previewButton.addTarget(self,
                                action: #selector(previewButtonTapped),
                                for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: previewButton)
        navigationItem.leftBarButtonItem = barButton
        
        collectionView.collectionViewLayout = createLayout()
        collectionView.registerCell(PreviewBemilyCollectionCell.self)
    }
    
    func anchorUI() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func scrollLastCollectionViewCell() {
        let lastItemIndex = dataSource.snapshot().numberOfItems(inSection: .main) - 1
        collectionView.scrollToItem(at: [0, lastItemIndex],
                                    at: .right,
                                    animated: true)
    }
    
    func showFailAlert(type: FailAlertType) {
        let alert = UIAlertController(title: type.title,
                                      message: nil,
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
