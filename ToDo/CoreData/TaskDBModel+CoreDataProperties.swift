//
//  TaskDBModel+CoreDataProperties.swift
//  ToDo
//
//  Created by Денис Королевский on 17/9/24.
//
//

import Foundation
import CoreData

@objc(TaskDBModel)
public class TaskDBModel: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskDBModel> {
        return NSFetchRequest<TaskDBModel>(entityName: "TaskDBModel")
    }
}

extension TaskDBModel {
    
    @NSManaged public var id: UUID?
    @NSManaged public var completed: Bool
    @NSManaged public var createDate: Date?
    @NSManaged public var descriptionText: String?
    @NSManaged public var titleText: String?
    
}

extension TaskDBModel : Identifiable {}
