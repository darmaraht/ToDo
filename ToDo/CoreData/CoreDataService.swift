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
    
    func createTask(id: UUID, title: String, description: String?, createDate: Date, completed: Bool, completion: (() -> Void)?) {
        DispatchQueue.background(background: {
            guard let taskEntityDescription = NSEntityDescription.entity(forEntityName: "TaskDBModel", in: self.context) else {
                return
            }
            
            let newTask = TaskDBModel(entity: taskEntityDescription, insertInto: self.context)
            newTask.id = id
            newTask.titleText = title
            newTask.descriptionText = description
            newTask.createDate = createDate
            newTask.completed = completed
            
            self.saveContext()
        }, completion: {
            completion?()
        })
    }
    
    func getAllTasks(completion: @escaping ([TaskDBModel]?) -> Void) {
        DispatchQueue.background(background: {
            let fetchRequest = NSFetchRequest<TaskDBModel>(entityName: "TaskDBModel")
            
            do {
                let tasks = try self.context.fetch(fetchRequest)
                completion(tasks)
            } catch {
                print("Ошибка загрузки задач: \(error.localizedDescription)")
                completion(nil)
            }
        })
    }
    
    func updateTask(id: String, title: String, description: String?, completed: Bool, completion: (() -> Void)?) {
        DispatchQueue.background(background: {
            let fetchRequest = NSFetchRequest<TaskDBModel>(entityName: "TaskDBModel")
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            do {
                if let taskToUpdate = try self.context.fetch(fetchRequest).first {
                    taskToUpdate.titleText = title
                    taskToUpdate.descriptionText = description
                    taskToUpdate.completed = completed
                    taskToUpdate.createDate = Date()
                    self.saveContext()
                }
            } catch {
                print("Ошибка обновления задачи: \(error.localizedDescription)")
            }
        }, completion: {
            completion?()
        })
    }
    
    func deleteTask(id: String, completion: (() -> Void)? = nil) {
        DispatchQueue.background(background: {
            let fetchRequest = NSFetchRequest<TaskDBModel>(entityName: "TaskDBModel")
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            do {
                if let taskToDelete = try self.context.fetch(fetchRequest).first {
                    self.context.delete(taskToDelete)
                    self.saveContext()
                }
            } catch {
                print("Ошибка удаления задачи: \(error.localizedDescription)")
            }
        }, completion: {
            completion?()
        })
    }
    
    
}

