//
//  UsersPresenter.swift
//  iOS6-HW26-Alexander.Strelkov
//
//  Created by Alexandr Strelkov on 25.08.2022.
//

import Foundation
import UIKit

protocol UsersPresenterProcotol: AnyObject {
    init(coreDataService: UserDataProtocol)
    func createNewUser(named title: String)
}

class UsersPresenter: UsersPresenterProcotol {
    let dataManager: UserDataProtocol?
    
    required init(coreDataService: UserDataProtocol) {
        self.dataManager = coreDataService
    }
    
    func createNewUser(named title: String) {
        dataManager?.createNewUser(named: title)
    }
}


