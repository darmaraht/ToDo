//
//  MainScreenPresenter.swift
//  ToDo
//
//  Created by Денис Королевский on 10/9/24.
//  
//

import Foundation

class MainScreenPresenter: ViewToPresenterMainScreenProtocol {

    // MARK: Properties
    var view: PresenterToViewMainScreenProtocol?
    var interactor: PresenterToInteractorMainScreenProtocol?
    var router: PresenterToRouterMainScreenProtocol?
}

extension MainScreenPresenter: InteractorToPresenterMainScreenProtocol {
    
}
