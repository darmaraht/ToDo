//
//  TabType.swift
//  ToDo
//
//  Created by Денис Королевский on 15/9/24.
//

import Foundation

enum TabType: CaseIterable {
    case all
    case open
    case closed
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .open:
            return "Open"
        case .closed:
            return "Closed"
        }
    }
}
