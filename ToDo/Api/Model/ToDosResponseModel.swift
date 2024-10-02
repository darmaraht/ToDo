//
//  ToDosResponseModel.swift
//  ToDo
//
//  Created by Денис Королевский on 15/9/24.
//

import Foundation

struct ToDosResponseModel: Decodable {
    
    struct ToDoModel: Decodable {
        let id: Int
        let todo: String
        let completed: Bool
    }
    
    let todos: [ToDoModel]
    let total: Int
    let skip: Int
    let limit: Int
}
