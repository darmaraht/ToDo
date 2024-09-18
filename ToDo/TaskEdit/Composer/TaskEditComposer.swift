//
//  TaskEditComposer.swift
//  ToDo
//
//  Created by Денис Королевский on 16/9/24.
//  2024
//

import UIKit

public struct TaskEditModuleInputContainer {
    let onTaskCreate: () -> Void
    let task: TaskDTO?
}

public enum TaskEditComposer {

    /// Creates new TaskEdit module.
    public static func make(input: TaskEditModuleInputContainer) -> UIViewController {
        let interactor = TaskEditInteractor(coreDataService: CoreDataService.shared)
        let router = TaskEditRouter()
        let presenter = TaskEditPresenter(
            interactor: interactor,
            router: router,
            task: input.task,
            onTaskCreate: input.onTaskCreate
        )
        let viewController = TaskEditViewController(presenter: presenter)
        router.viewController = viewController
        presenter.view = viewController
        return viewController
    }

}
