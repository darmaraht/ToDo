//
//  ToDosResponseModel.swift
//  ToDo
//
//  Created by Денис Королевский on 15/9/24.
//

import Foundation

struct ToDosResponseModel: Codable {
    
    struct ToDoModel: Codable {
        let id: Int
        let todo: String
        let completed: Bool
    }
    
    let todos: [ToDoModel]
    let total: Int
    let skip: Int
    let limit: Int
}
