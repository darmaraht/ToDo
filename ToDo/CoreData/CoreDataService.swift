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
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    // MARK: CRUD
    
    public func createTask(id: UUID, title: String, description: String?, createDate: Date, completed: Bool) {
        guard let taskEntityDescription = NSEntityDescription.entity(forEntityName: "TaskDBModel", in: context) else {
            return
        }
        
        let newTask = TaskDBModel(entity: taskEntityDescription, insertInto: context)
        newTask.id = id
        newTask.titleText = title
        newTask.descriptionText = description
        newTask.createDate = createDate
        newTask.completed = completed
        
        appDelegate.saveContext()
    }
    
    public func fetchAllTasks() -> [TaskDBModel]? {
        let fetchRequest = NSFetchRequest<TaskDBModel>(entityName: "TaskDBModel")
        
        do {
            let tasks = try context.fetch(fetchRequest)
            return tasks
        } catch {
            print("Ошибка загрузки задач: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func updateTask(id: String, title: String, description: String?, completed: Bool) {
        let fetchRequest = NSFetchRequest<TaskDBModel>(entityName: "TaskDBModel")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            if let taskToUpdate = try context.fetch(fetchRequest).first {
                taskToUpdate.titleText = title
                taskToUpdate.descriptionText = description
                taskToUpdate.completed = completed
                taskToUpdate.createDate = Date()
                appDelegate.saveContext()
            }
        } catch {
            print("Ошибка обновления задачи: \(error.localizedDescription)")
        }
    }
    
    public func deleteTask(id: String) {
        let fetchRequest = NSFetchRequest<TaskDBModel>(entityName: "TaskDBModel")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            if let taskToDelete = try context.fetch(fetchRequest).first {
                context.delete(taskToDelete)
                appDelegate.saveContext()
            }
        } catch {
            print("Ошибка удаления задачи: \(error.localizedDescription)")
        }
    }
    
    
}

