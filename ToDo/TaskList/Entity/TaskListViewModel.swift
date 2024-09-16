//
//  TaskListViewModel.swift
//  ToDo
//
//  Created by Денис Королевский on 15/9/24.
//

import Foundation

struct TaskListViewModel {
    let title: String
    var dateString: String
    var tabsViewModels: [TabViewModel]
    var taskListTableViewModel: TaskListTableViewModel
}

struct TaskListTableViewModel {
    var tasksViewModels: [TaskViewModel]
    var taskListOffset: CGPoint
}

struct TabViewModel {
    let type: TabType
    var counterString: String
    var isSelected: Bool
}


struct TaskViewModel {
    let id: String
    var title: String
    var description: String
    let dateString: String
    var isClosed: Bool
    
}
