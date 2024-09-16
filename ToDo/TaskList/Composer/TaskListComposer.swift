//
//  TaskListComposer.swift
//  ToDo
//
//  Created by Денис Королевский on 10/9/24.
//  2024
//

import UIKit

public struct TaskListModuleInputContainer {
    let titleString: String
}

public enum TaskListComposer {

    /// Creates new TaskList module.
    public static func make(input: TaskListModuleInputContainer) -> UIViewController {
        let interactor = TaskListInteractor()
        let router = TaskListRouter()
        let presenter = TaskListPresenter(
            interactor: interactor,
            router: router,
            inputModel: input, 
            flowModel: .init(tasks: [], selectedTabType: .all)
        )
        let viewController = TaskListViewController(presenter: presenter)
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.view = viewController
        return viewController
    }

}
