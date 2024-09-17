//
//  TaskEditComposer.swift
//  ToDo
//
//  Created by Денис Королевский on 16/9/24.
//  2024
//

import UIKit

public struct TaskEditModuleInputContainer {
    
}

public enum TaskEditComposer {

    /// Creates new TaskEdit module.
    public static func make(input: TaskEditModuleInputContainer? = nil) -> UIViewController {
        let interactor = TaskEditInteractor()
        let router = TaskEditRouter()
        let presenter = TaskEditPresenter(
            interactor: interactor,
            router: router
        )
        let viewController = TaskEditViewController(presenter: presenter)
        router.viewController = viewController
        presenter.view = viewController
        return viewController
    }

}
