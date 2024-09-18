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
    
    // MARK: Init
    
    init(
        interactor: TaskEditInteractorInput,
        router: TaskEditRouterInput,
        onTaskCreate: @escaping () -> Void
    ) {
        self.interactor = interactor
        self.router = router
        self.onTaskCreate = onTaskCreate
    }
    
}

// MARK: - TaskEditPresenterInput

extension TaskEditPresenter: TaskEditPresenterInput {
    
    func viewDidLoad() {
        
    }
    
    func saveTaskDidTap(titleText: String, descriptionText: String) {
        let uuid = UUID().uuidString
        
        let taskDTO = TaskDTO(
            id: uuid,
            titleText: titleText,
            descriptionText: descriptionText,
            createDate: Date(),
            completed: false
        )
        
        interactor.saveTask(task: taskDTO)
        onTaskCreate?()
        router.dismissEditViewController()
    }
    
}
