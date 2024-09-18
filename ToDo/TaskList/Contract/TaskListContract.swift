//
//  TaskListContract.swift
//  ToDo
//
//  Created by Денис Королевский on 10/9/24.
//  2024
//

import Foundation

protocol TaskListPresenterInput {
    func viewDidLoad()
    func didSelectTab(with type: TabType)
    func didChangeTaskStatus(with id: String)
    func didChangeContentOffset(_ offset: CGPoint)
    func newTaskButtonDidTap()
    func deleteTask(with id: String)
    func didSelectTask(with id: String) 
}

protocol TaskListViewControllerInput: AnyObject {
    func updateUI(with viewModel: TaskListViewModel)
}

protocol TaskListInteractorInput {
    func loadTasks(resultHandler: @escaping (Result<[TaskDTO], any Error>) -> Void)
    func updateTask(task: TaskDTO)
    func deleteTask(id: String, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol TaskListRouterInput {
    func routeToTaskEdit(task: TaskDTO?, onTaskCreate: @escaping () -> Void)
}



