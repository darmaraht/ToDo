//
//  TaskListRouter.swift
//  ToDo
//
//  Created by Денис Королевский on 10/9/24.
//  2024
//

import UIKit

internal final class TaskListRouter {
    
    weak var viewController: UIViewController?
    
}

extension TaskListRouter: TaskListRouterInput {
    
    func routeToTaskEdit() {
        let taskEditViewController = TaskEditComposer.make()
        viewController?.present(taskEditViewController, animated: true)
    }
}
