//
//  TaskEditInteractor.swift
//  ToDo
//
//  Created by Денис Королевский on 16/9/24.
//  2024
//

import Foundation

final class TaskEditInteractor {
    
    // MARK: Dependencies
    private let coreDataService: CoreDataService
    
    // MARK: Init
    
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
    }
    
    func saveTask(task: TaskDTO) {
        
        if let taskUUID = UUID(uuidString: task.id) {
            coreDataService.createTask(
                id: taskUUID,
                title: task.titleText,
                description: task.descriptionText,
                createDate: task.createDate,
                completed: task.completed
            )
        } else {
            print("Error: Invalid UUID string.")
        }
        
    }
    
    func updateTask(_ task: TaskDTO) {
        coreDataService.updateTask(
            id: task.id,
            title: task.titleText,
            description: task.descriptionText,
            completed: task.completed
        )
    }
    
}

// MARK: - TaskEditInteractorInput

extension TaskEditInteractor: TaskEditInteractorInput {
    
    
}
