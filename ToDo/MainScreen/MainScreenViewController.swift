//
//  MainScreenViewController.swift
//  ToDo
//
//  Created by Денис Королевский on 10/9/24.
//  
//

import UIKit

class MainScreenViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterMainScreenProtocol?
    
}

extension MainScreenViewController: PresenterToViewMainScreenProtocol{
    // TODO: Implement View Output Methods
}
