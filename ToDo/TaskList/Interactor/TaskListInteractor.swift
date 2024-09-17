//
//  TaskListInteractor.swift
//  ToDo
//
//  Created by Денис Королевский on 10/9/24.
//  2024
//

import Foundation

final class TaskListInteractor: TaskListInteractorInput {
    
    // MARK: Properties
    
    var presenter: TaskListPresenterInput?
    
    // MARK: Init
    
    init() {}
    
    // MARK: TaskListInteractorInput
    
    func loadTasks(resultHandler: @escaping (Result<[ToDosResponseModel.ToDoModel], any Error>) -> Void) {
        // Проверяем наличие задач в CoreData
        if let savedTasks = CoreDataService.shared.fetchAllTasks(), !savedTasks.isEmpty {
            print("@@@ - Отображаем задачи из CoreData")
            let mappedTasks = savedTasks.map { task in
                ToDosResponseModel.ToDoModel(
                    id: Int(bitPattern: task.id),
                    todo: task.titleText ?? "",
                    completed: task.completed
                )
            }
            resultHandler(.success(mappedTasks))
        } else {
            print("@@@ - Отображаем задачи из Api")
            ApiService.shared.loadTasks { result in
                switch result {
                case .success(let responseModel):
                    let todos = responseModel.todos
                    
                    // Получаем уже существующие задачи из CoreData
                    let existingTasks = CoreDataService.shared.fetchAllTasks() ?? []
                    
                    // Сохраняем только новые задачи
                    todos.forEach { todo in
                        if !existingTasks.contains(where: { Int(bitPattern: $0.id) == todo.id }) {
                            CoreDataService.shared.createTask(
                                id: UUID(),
                                title: todo.todo,
                                description: "",
                                createDate: .now,
                                completed: todo.completed
                            )
                        }
                    }
                    
                    // После сохранения загружаем задачи из CoreData и возвращаем их
                    if let savedTasks = CoreDataService.shared.fetchAllTasks() {
                        let mappedTasks = savedTasks.map { task in
                            ToDosResponseModel.ToDoModel(
                                id: Int(bitPattern: task.id),
                                todo: task.titleText ?? "",
                                completed: task.completed
                            )
                        }
                        resultHandler(.success(mappedTasks))
                    }
                    
                case .failure(let error):
                    resultHandler(.failure(error))
                }
            }
        }
    }
    
}
