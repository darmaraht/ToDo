//
//  TaskListViewController.swift
//  ToDo
//
//  Created by Денис Королевский on 10/9/24.
//  2024
//

import UIKit

final class TaskListViewController: UIViewController {
    
    // MARK: Dependencies
    
    private let presenter: TaskListPresenterInput
    
    // MARK: Subviews
    
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let newTaskButton = UIButton()
    private let tabsView = TabsView()
    private let taskListView = TaskListView()
    
    // MARK: Properties
    
    // MARK: Init
    
    init(presenter: TaskListPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupUI()
        presenter.viewDidLoad()
        tabsView.updateSelectionHandler({ [weak self] type in
            self?.presenter.didSelectTab(with: type)
        })
        taskListView.updateScrollHandler({ [weak self] offset in
            self?.presenter.didChangeContentOffset(offset)
        })
        newTaskButton.addTarget(self, action: #selector(newTaskButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        setupTitleLabel()
        setupDateLabel()
        setupNewTaskButton()
        setupTabsView()
        setupTaskListView()
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.backgroundColor = .clear
        titleLabel.text = "Today's Task"
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
        }
    }
    
    private func setupDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.backgroundColor = .clear
        dateLabel.text = "Wednesday, 11 May"
        dateLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .center
        dateLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    private func setupNewTaskButton() {
        view.addSubview(newTaskButton)
        
        var config = UIButton.Configuration.plain()
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
        config.image = UIImage(systemName: "plus", withConfiguration: symbolConfig)
        config.attributedTitle = AttributedString("New Task", attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]))
        config.baseForegroundColor = .systemBlue
        config.imagePadding = 8
        config.imagePlacement = .leading
        
        newTaskButton.backgroundColor = .buttonColor
        newTaskButton.configuration = config
        newTaskButton.titleLabel?.lineBreakMode = .byClipping
        newTaskButton.layer.cornerRadius = 12
        newTaskButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(140)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.right.equalToSuperview().inset(20)
        }
        
        
    }
    
    private func setupTabsView() {
        view.addSubview(tabsView)
        
        tabsView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(30)
        }
    }
    
    private func setupTaskListView() {
        view.addSubview(taskListView)
        
        taskListView.snp.makeConstraints {
            $0.top.equalTo(tabsView.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    @objc
    private func newTaskButtonDidTap() {
        presenter.newTaskButtonDidTap()
    }
    
}

// MARK: - TaskListViewControllerInput

extension TaskListViewController: TaskListViewControllerInput {
    func updateUI(with viewModel: TaskListViewModel) {
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.dateString
        tabsView.updateUI(with: viewModel.tabsViewModels)
        taskListView.updateUI(with: viewModel.taskListTableViewModel)
        taskListView.updateHandlers(checkMarkTapHandler: { [weak self] id in
            self?.presenter.didChangeTaskStatus(with: id)
        })
    }
}

