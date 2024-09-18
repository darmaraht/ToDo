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
    
    func routeToTaskEdit(task: TaskDTO?, onTaskCreate: @escaping () -> Void) {
        let taskEditViewController = TaskEditComposer.make(input: .init(onTaskCreate: onTaskCreate, task: task))
        viewController?.present(taskEditViewController, animated: true)
    }
    
}
