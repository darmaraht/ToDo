//
//  TaskEditPresenter.swift
//  ToDo
//
//  Created by Денис Королевский on 16/9/24.
//  2024
//

import Foundation

final class TaskEditPresenter {

    // MARK: Dependencies

    private let interactor: TaskEditInteractorInput
    private let router: TaskEditRouterInput
    weak var view: TaskEditViewControllerInput?

    // MARK: Properties


    // MARK: Init

    init(
        interactor: TaskEditInteractorInput,
        router: TaskEditRouterInput
    ) {
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - TaskEditPresenterInput

extension TaskEditPresenter: TaskEditPresenterInput {
    
    func viewDidLoad() {
        
    }
    
}
