//
//  TaskDTO.swift
//  ToDo
//
//  Created by Денис Королевский on 15/9/24.
//

import Foundation

struct TaskDTO {
    let id: String
    var titleText: String
    var descriptionText: String?
    let createDate: Date
    var completed: Bool
    
    
    init(from: ToDosResponseModel.ToDoModel) {
        self.id = "\(from.id)"
        self.titleText = from.todo
        self.createDate = .now
        self.completed = from.completed
    }
    
    init(id: String, titleText: String, descriptionText: String? = nil, createDate: Date, completed: Bool) {
        self.id = id
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.createDate = createDate
        self.completed = completed
    }
    
}
