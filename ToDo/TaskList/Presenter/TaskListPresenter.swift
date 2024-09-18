//
//  TaskListPresenter.swift
//  ToDo
//
//  Created by Денис Королевский on 10/9/24.
//  2024
//

import Foundation

final class TaskListPresenter {
    
    // MARK: Dependencies
    
    private let interactor: TaskListInteractorInput
    private let router: TaskListRouterInput
    weak var view: TaskListViewControllerInput?
    
    // MARK: Properties
    
    private let inputModel: TaskListModuleInputContainer
    private var flowModel: TaskListFlowModel
    private let dateFormatter = DateFormatter()
    private let taskDateFormatter = DateFormatter()
    private var offsetCache: [TabType: CGPoint] = [:]
    
    // MARK: Init
    
    init(
        interactor: TaskListInteractorInput,
        router: TaskListRouterInput,
        inputModel: TaskListModuleInputContainer,
        flowModel: TaskListFlowModel
    ) {
        self.interactor = interactor
        self.router = router
        self.inputModel = inputModel
        self.flowModel = flowModel
    }
    
    private func createViewModel() -> TaskListViewModel {
        
        dateFormatter.dateFormat = "EEEE, d MMMM"
        taskDateFormatter.dateFormat = "EEEE, d MMMM, h:mm:ss"
        
        var tabsViewModels: [TabViewModel] = []
        var tasksViewModels: [TaskViewModel] = []
        let sortedTasks = flowModel.tasks.sorted(by: { $0.createDate > $1.createDate })
        let openTasks = sortedTasks.filter { !$0.completed }
        let closedTasks = sortedTasks.filter { $0.completed }
        
        tabsViewModels = TabType.allCases.map {
            switch $0 {
                
            case .all:
                return .init(
                    type: $0,
                    counterString: "\(flowModel.tasks.count)",
                    isSelected: flowModel.selectedTabType == $0
                )
            case .open:
                return .init(
                    type: $0,
                    counterString: "\(openTasks.count)",
                    isSelected: flowModel.selectedTabType == $0
                )
            case .closed:
                return .init(
                    type: $0,
                    counterString: "\(closedTasks.count)",
                    isSelected: flowModel.selectedTabType == $0
                )
            }
        }
        
        
        
        switch flowModel.selectedTabType {
            
        case .all:
            tasksViewModels = sortedTasks.map {
                .init(
                    id: $0.id,
                    title: $0.titleText,
                    description: $0.descriptionText ?? "",
                    dateString: taskDateFormatter.string(from: $0.createDate),
                    isClosed: $0.completed
                )
            }
        case .open:
            tasksViewModels = openTasks.map {
                .init(
                    id: $0.id,
                    title: $0.titleText,
                    description: $0.descriptionText ?? "",
                    dateString: taskDateFormatter.string(from: $0.createDate),
                    isClosed: $0.completed
                )
            }
        case .closed:
            tasksViewModels = closedTasks.map {
                .init(
                    id: $0.id,
                    title: $0.titleText,
                    description: $0.descriptionText ?? "",
                    dateString: taskDateFormatter.string(from: $0.createDate),
                    isClosed: $0.completed
                )
            }
        }
        
       
        
        return TaskListViewModel(
            title: "Today's Task",
            dateString: dateFormatter.string(from: Date()),
            tabsViewModels: tabsViewModels, 
            taskListTableViewModel: .init(
                tasksViewModels: tasksViewModels,
                taskListOffset: offsetCache[flowModel.selectedTabType] ?? .zero
            )
        )
    }
    
}

// MARK: - TaskListPresenterInput

extension TaskListPresenter: TaskListPresenterInput {
    
    func viewDidLoad() {
        loadTasksAndPresent()
    }
    
    private func loadTasksAndPresent() {
        interactor.loadTasks(resultHandler: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let tasks):
                self.flowModel.tasks = tasks
                
//                tasks.forEach {
//                    let taskDTO = TaskDTO(
//                        id: "\($0.id)",
//                        titleText: $0.todo,
//                        createDate: Date(),
//                        completed: $0.completed
//                    )
//                    self.flowModel.tasks.append( taskDTO )
//                }
                let viewModel = self.createViewModel()
                self.view?.updateUI(with: viewModel)
//                print("Задачи загружены: \(tasks)")
            case .failure(let error):
                print("Не удалось загрузить задачи: \(error)")
            }
        })
    }
  
    
    func didSelectTab(with type: TabType) {
        flowModel.selectedTabType = type
        view?.updateUI(with: createViewModel())
    }
    
    func didChangeTaskStatus(with id: String) {
        guard let taskIndex = flowModel.tasks.firstIndex(where: { $0.id == id }) else { return }
        flowModel.tasks[taskIndex].completed.toggle()
        view?.updateUI(with: createViewModel())
    }
    
    func didChangeContentOffset(_ offset: CGPoint) {
        offsetCache[flowModel.selectedTabType] = offset
    }
    
    func newTaskButtonDidTap() {
        router.routeToTaskEdit(onTaskCreate: { [weak self] in
            self?.loadTasksAndPresent()
        })
    }
}
