//
//  CoreDataService.swift
//  ToDo
//
//  Created by Денис Королевский on 17/9/24.
//

import UIKit
import CoreData

public final class CoreDataService: NSObject {
    
    public static let shared = CoreDataService()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskDBModel")
        container.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("DB URL - ", description.url ?? "")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Ошибка сохранения контекста: \(error), \(error.userInfo)")
            }
        }
    }
    
}

// MARK: - Public CRUD

extension CoreDataService {
    
    func createTask(id: UUID, title: String, description: String?, createDate: Date, completed: Bool) {
        guard let taskEntityDescription = NSEntityDescription.entity(forEntityName: "TaskDBModel", in: context) else {
            return
        }
        
        let newTask = TaskDBModel(entity: taskEntityDescription, insertInto: context)
        newTask.id = id
        newTask.titleText = title
        newTask.descriptionText = description
        newTask.createDate = createDate
        newTask.completed = completed
        
        self.saveContext()
    }
    
    func getAllTasks() -> [TaskDBModel]? {
        let fetchRequest = NSFetchRequest<TaskDBModel>(entityName: "TaskDBModel")
        
        do {
            let tasks = try context.fetch(fetchRequest)
            return tasks
        } catch {
            print("Ошибка загрузки задач: \(error.localizedDescription)")
            return nil
        }
    }
    
    func updateTask(id: String, title: String, description: String?, completed: Bool) {
        let fetchRequest = NSFetchRequest<TaskDBModel>(entityName: "TaskDBModel")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            if let taskToUpdate = try context.fetch(fetchRequest).first {
                taskToUpdate.titleText = title
                taskToUpdate.descriptionText = description
                taskToUpdate.completed = completed
                taskToUpdate.createDate = Date()
                self.saveContext()
            }
        } catch {
            print("Ошибка обновления задачи: \(error.localizedDescription)")
        }
    }
    
    func deleteTask(id: String) {
        let fetchRequest = NSFetchRequest<TaskDBModel>(entityName: "TaskDBModel")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            if let taskToDelete = try context.fetch(fetchRequest).first {
                context.delete(taskToDelete)
                self.saveContext()
            }
        } catch {
            print("Ошибка удаления задачи: \(error.localizedDescription)")
        }
    }
    
    
}

