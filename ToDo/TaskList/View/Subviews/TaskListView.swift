//
//  TaskListView.swift
//  ToDo
//
//  Created by Денис Королевский on 12/9/24.
//

import UIKit
import SnapKit

class TaskListView: UIView {
    
    private var taskViewModels: [TaskViewModel] = []
    private var checkMarkTapHandler: ((String) -> Void)? = nil
    private var scrollChangeHandler: ((CGPoint) -> Void)?
    private var rowSwipeHandler: ((String) -> Void)?
    private var rowTapHandler: ((String) -> Void)?
    
    // MARK: Subviews
    
    private let taskTableView: UITableView
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        taskTableView = UITableView()
        taskTableView.separatorStyle = .none
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        taskTableView = UITableView()
        taskTableView.separatorStyle = .singleLine
        
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: Setup UI
    private func setupUI() {
        addSubview(taskTableView)
        
        taskTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseId)
        taskTableView.showsVerticalScrollIndicator = false
        taskTableView.backgroundColor = .systemGray6
        
        taskTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
        taskTableView.reloadData()
    }
    
    func updateUI(with viewModel: TaskListTableViewModel) {
        taskViewModels = viewModel.tasksViewModels
        taskTableView.setContentOffset(.zero, animated: false)
        taskTableView.reloadData()
        taskTableView.setContentOffset(viewModel.taskListOffset, animated: false)
    }
    
    func updateHandlers(checkMarkTapHandler: @escaping (String) -> Void) {
        self.checkMarkTapHandler = checkMarkTapHandler
    }
    
    func updaterowTapHandler(rowTapHandler: @escaping (String) -> Void) {
        self.rowTapHandler = rowTapHandler
    }
    
    func updateScrollHandler(_ handler: @escaping (CGPoint) -> Void) {
        scrollChangeHandler = handler
    }
    
    func updateSwipeHandler(_ handler: @escaping (String) -> Void) {
        self.rowSwipeHandler = handler
    }
    
}

// MARK: - UITableViewDataSource

extension TaskListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseId, for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        let taskViewModel = taskViewModels[indexPath.row]
        cell.update(with: taskViewModel)
        cell.updateCheckMarkTapHandler({ [weak self] in
            self?.checkMarkTapHandler?(taskViewModel.id)
        })
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollChangeHandler?(taskTableView.contentOffset)
    }
    
}

// MARK: - UITableViewDelegate

extension TaskListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let taskId = taskViewModels[indexPath.row].id
        
        rowTapHandler?(taskId)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else { return }
            let taskId = self.taskViewModels[indexPath.row].id
            self.rowSwipeHandler?(taskId)
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}


