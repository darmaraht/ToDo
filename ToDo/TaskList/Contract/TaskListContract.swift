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
}

protocol TaskListViewControllerInput: AnyObject {
    func updateUI(with viewModel: TaskListViewModel)
}

protocol TaskListInteractorInput {
    func loadTasks(resultHandler: @escaping (Result<[ToDosResponseModel.ToDoModel], any Error>) -> Void)
}

protocol TaskListRouterInput {
    func routeToTaskEdit()
}



