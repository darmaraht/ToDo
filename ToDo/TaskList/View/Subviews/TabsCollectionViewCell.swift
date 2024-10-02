//
//  TabsCollectionViewCell.swift
//  ToDo
//
//  Created by Денис Королевский on 11/9/24.
//

import UIKit
import SnapKit

final class TabsCollectionViewCell: UICollectionViewCell {

    
    // MARK: SubViews
    
    private let titleLabel = UILabel()
    private let badgeLabel = UILabel()
    private let badgeColorView = UIView()
    
    // MARK: Properties
    
    static let reuseId = "tabsCell"
    
    // MARK: Init
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           setupUI()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    // MARK: setup UI
    
    private func setupUI() {
        backgroundColor = .systemGray6
        clipsToBounds = true

        contentView.addSubview(titleLabel)
        contentView.addSubview(badgeColorView)
        contentView.addSubview(badgeLabel)

        titleLabel.textColor = .gray
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        
        badgeColorView.backgroundColor = .systemGray3
        badgeColorView.clipsToBounds = true
        badgeColorView.layer.cornerRadius = 10
        badgeColorView.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.left.equalTo(titleLabel.snp.right).offset(6)
            $0.right.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
        }
        
        badgeLabel.textColor = .white
        badgeLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        badgeLabel.textAlignment = .center
        badgeLabel.backgroundColor = .clear
        badgeLabel.snp.makeConstraints {
            $0.centerY.equalTo(badgeColorView)
            $0.left.equalTo(badgeColorView.snp.left).offset(4)
            $0.right.equalTo(badgeColorView.snp.right).offset(-4)
        }
    }

    func update(with viewModel: TabViewModel) {
        titleLabel.text = viewModel.type.title
        badgeLabel.text = viewModel.counterString
        if viewModel.isSelected {
            badgeColorView.backgroundColor = .systemBlue
            titleLabel.textColor = .systemBlue
        } else {
            badgeColorView.backgroundColor = .gray
            titleLabel.textColor = .black
        }
    }
}
