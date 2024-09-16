//
//  MainScreenContract.swift
//  ToDo
//
//  Created by Денис Королевский on 10/9/24.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewMainScreenProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMainScreenProtocol {
    
    var view: PresenterToViewMainScreenProtocol? { get set }
    var interactor: PresenterToInteractorMainScreenProtocol? { get set }
    var router: PresenterToRouterMainScreenProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMainScreenProtocol {
    
    var presenter: InteractorToPresenterMainScreenProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMainScreenProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMainScreenProtocol {
    
}
