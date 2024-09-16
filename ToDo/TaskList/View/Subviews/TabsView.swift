//
//  TabsView.swift
//  ToDo
//
//  Created by Денис Королевский on 11/9/24.
//

import UIKit
import SnapKit

class TabsView: UIView {
    
    // MARK: Properties
    
    private var tabViewModels: [TabViewModel] = []
    private var selectionHandler: ((TabType) -> Void)? = nil
    
    // MARK: Subviews
    
    private let tabsCollectionView: UICollectionView
        
    // MARK: Init
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        tabsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        tabsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        backgroundColor = .systemGray6
        
        tabsCollectionView.register(TabsCollectionViewCell.self, forCellWithReuseIdentifier: TabsCollectionViewCell.reuseId)
        tabsCollectionView.backgroundColor = .systemGray6
        
        addSubview(tabsCollectionView)
        tabsCollectionView.showsHorizontalScrollIndicator = false
        tabsCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
      
        tabsCollectionView.dataSource = self
        tabsCollectionView.delegate = self
        tabsCollectionView.reloadData()

        
    }
    
    func updateUI(with viewModels: [TabViewModel]) {
        tabViewModels = viewModels
        tabsCollectionView.reloadData()
    }
    
    func updateSelectionHandler(_ handler: @escaping (TabType) -> Void) {
        selectionHandler = handler
    }
}

// MARK: - UICollectionViewDataSource

extension TabsView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabsCollectionViewCell.reuseId, for: indexPath) as? TabsCollectionViewCell else {
            fatalError("Unable to dequeue TabsCollectionViewCell")
        }
        cell.update(with: tabViewModels[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension TabsView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectionHandler?(tabViewModels[indexPath.item].type)
    }
    
}


