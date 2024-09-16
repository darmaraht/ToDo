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
        ApiService.shared.loadTasks { result in
            switch result {
            case .success(let responseModel):
                resultHandler(.success(responseModel.todos))
            case .failure(let error):
                resultHandler(.failure(error))
            }
        }
    }
    
}
