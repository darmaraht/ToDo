//
//  TaskListInteractor.swift
//  ToDo
//
//  Created by Денис Королевский on 10/9/24.
//  2024
//

import Foundation

final class TaskListInteractor: TaskListInteractorInput {
    
    // MARK: Dependencies
    private let coreDataService: CoreDataService
    
    // MARK: Properties
    
    var presenter: TaskListPresenterInput?
    
    // MARK: Init
    
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
    
    // MARK: TaskListInteractorInput
    
    func loadTasks(resultHandler: @escaping (Result<[TaskDTO], any Error>) -> Void) {
        if let savedTasks = CoreDataService.shared.fetchAllTasks(), !savedTasks.isEmpty {
            print("@@@ - Отображаем задачи из CoreData")
            let mappedTasks = savedTasks.map { task in
                TaskDTO(
                    id: task.id?.uuidString ?? "",
                    titleText: task.titleText ?? "",
                    descriptionText: task.descriptionText,
                    createDate: task.createDate ?? Date(),
                    completed: task.completed
                )
            }
            resultHandler(.success(mappedTasks))
        }  else {
            print("@@@ - Отображаем задачи из Api")
            ApiService.shared.loadTasks { result in
                switch result {
                case .success(let responseModel):
                    let todos = responseModel.todos
                    
                    todos.forEach { todo in
                        CoreDataService.shared.createTask(
                            id: UUID(),
                            title: todo.todo,
                            description: "",
                            createDate: .now,
                            completed: todo.completed
                        )
                    }
                    
                    let mappedTasks = todos.map { TaskDTO(from: $0) }
                    resultHandler(.success(mappedTasks))
                    
                case .failure(let error):
                    resultHandler(.failure(error))
                }
            }
        }
    }
    
}
