//
//  TaskEditRouter.swift
//  ToDo
//
//  Created by Денис Королевский on 16/9/24.
//  2024
//

import UIKit

internal final class TaskEditRouter {
    
    weak var viewController: UIViewController?
    
    func dismissEditViewController() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
}

extension TaskEditRouter: TaskEditRouterInput {}
