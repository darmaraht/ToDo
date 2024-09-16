//
//  TaskTableViewCell.swift
//  ToDo
//
//  Created by Денис Королевский on 12/9/24.
//

import UIKit
import SnapKit

class TaskTableViewCell: UITableViewCell {
    
    // MARK: SubViews
    
    private let backgroundCellView = UIView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let dateLabel = UILabel()
    private let horisontalSeparatorView = UIView()
    private let checkMarkButton = UIButton(type: .system)
    
    // MARK: Properties
    static let reuseId = "taskCell"
    private var checkMarkTapHandler: (() -> Void)? = nil
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setup UI
    
    private func setupUI() {
        backgroundColor = .systemGray6
        clipsToBounds = true
        
        contentView.addSubview(backgroundCellView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(horisontalSeparatorView)
        contentView.addSubview(checkMarkButton)
        
        backgroundCellView.backgroundColor = .white
        backgroundCellView.clipsToBounds = true
        backgroundCellView.layer.cornerRadius = 16
        backgroundCellView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundCellView.snp.top).offset(20)
            $0.left.equalTo(backgroundCellView.snp.left).offset(20)
            $0.right.equalTo(checkMarkButton.snp.left).offset(-20)
        }
        
        subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        subTitleLabel.textColor = .gray
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.left.equalTo(backgroundCellView.snp.left).offset(20)
            $0.right.equalTo(checkMarkButton.snp.left).offset(-20)
        }
        
        checkMarkButton.tintColor = .gray
        checkMarkButton.snp.makeConstraints {
            $0.top.equalTo(backgroundCellView.snp.top).offset(20)
            $0.right.equalTo(backgroundCellView.snp.right).offset(-10)
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        horisontalSeparatorView.backgroundColor = .gray
        horisontalSeparatorView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(12)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }
        
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .gray
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(horisontalSeparatorView.snp.bottom).offset(12)
            $0.left.equalTo(backgroundCellView.snp.left).offset(20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }

    func update(with viewModel: TaskViewModel) {
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.description
        dateLabel.text = viewModel.dateString
        if viewModel.isClosed {
            checkMarkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            checkMarkButton.tintColor = .systemBlue
        } else {
            checkMarkButton.setImage(UIImage(systemName: "circle"), for: .normal)
            checkMarkButton.tintColor = .gray
        }
    }
    
    func updateCheckMarkTapHandler(_ handler: @escaping () -> Void) {
        checkMarkTapHandler = handler
    }
    
    // MARK: Setup Actions
    
    private func setupActions() {
        checkMarkButton.addTarget(self, action: #selector(didTapCheckMark), for: .touchUpInside)
    }
    
    @objc
    private func didTapCheckMark() {
        checkMarkTapHandler?()
    }
}
