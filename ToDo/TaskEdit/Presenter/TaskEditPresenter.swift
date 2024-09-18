//
//  TaskEditPresenter.swift
//  ToDo
//
//  Created by Денис Королевский on 16/9/24.
//  2024
//

import Foundation

final class TaskEditPresenter {
    
    // MARK: Dependencies
    
    private let interactor: TaskEditInteractorInput
    private let router: TaskEditRouterInput
    weak var view: TaskEditViewControllerInput?
    
    // MARK: Properties
    
    private var onTaskCreate: (() -> Void)?
    private var inputTask: TaskDTO?
    
    // MARK: Init
    
    init(
        interactor: TaskEditInteractorInput,
        router: TaskEditRouterInput,
        task: TaskDTO?,
        onTaskCreate: @escaping () -> Void
    ) {
        self.interactor = interactor
        self.router = router
        self.inputTask = task
        self.onTaskCreate = onTaskCreate
    }
    
}

// MARK: - TaskEditPresenterInput

extension TaskEditPresenter: TaskEditPresenterInput {
    
    func viewDidLoad() {
        guard let inputTask else { return }
        view?.update(title: inputTask.titleText, description: inputTask.descriptionText)
    }
    
    func saveTaskDidTap(titleText: String, descriptionText: String) {
        
        if var inputTask {
            inputTask.titleText = titleText
            inputTask.descriptionText = descriptionText
            interactor.updateTask(inputTask)
        } else {
            let uuid = UUID().uuidString
            let taskDTO = TaskDTO(
                id: uuid,
                titleText: titleText,
                descriptionText: descriptionText,
                createDate: Date(),
                completed: false
            )
            interactor.saveTask(task: taskDTO)
        }
        onTaskCreate?()
        router.dismissEditViewController()
    }
}
