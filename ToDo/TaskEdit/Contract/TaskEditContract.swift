//
//  TaskEditContract.swift
//  ToDo
//
//  Created by Денис Королевский on 16/9/24.
//  2024
//

import Foundation

protocol TaskEditPresenterInput {
    func viewDidLoad()
    func saveButtonDidTap()
}

protocol TaskEditViewControllerInput: AnyObject {}

protocol TaskEditInteractorInput {
    
}

protocol TaskEditRouterInput {
    func dismissEditViewController()
}
