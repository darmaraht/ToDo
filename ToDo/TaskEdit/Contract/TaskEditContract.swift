//
//  TaskEditContract.swift
//  ToDo
//
//  Created by Денис Королевский on 16/9/24.
//  2024
//

import Foundation

protocol TaskEditPresenterInput {
    func viewDidLoad()
    func saveTaskDidTap(titleText: String, descriptionText: String)
}

protocol TaskEditViewControllerInput: AnyObject {
    func showError(message: String)
    func update(title: String, description: String?)
}

protocol TaskEditInteractorInput {
    func saveTask(task: TaskDTO, completion: (() -> Void)?)
    func updateTask(_ task: TaskDTO, completion: (() -> Void)?)
}

protocol TaskEditRouterInput {
    func dismissEditViewController()
}
