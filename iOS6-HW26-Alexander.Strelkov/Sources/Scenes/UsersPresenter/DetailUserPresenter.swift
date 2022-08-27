//
//  DetailUserPresenter.swift
//  iOS6-HW26-Alexander.Strelkov
//
//  Created by Alexandr Strelkov on 26.08.2022.
//

import Foundation

protocol DetailUserViewProtocol: AnyObject {
    func setupTextFields()
}

protocol DetailUserPresenterProtocol: AnyObject {
    var userToEdit: User? { get set }

    init(view: DetailUserViewProtocol, coreDataService: UserDataProtocol, user: User?)
    func getUser()
    func updateUser(_ user: User, newName: String?, date: String?, gender: String?)
}

class DetailUserPresenter: DetailUserPresenterProtocol {
    
    weak var view: DetailUserViewProtocol?
    let dataManager: UserDataProtocol?
    var userToEdit: User?
    
    required init(view: DetailUserViewProtocol, coreDataService: UserDataProtocol, user: User?) {
        self.dataManager = coreDataService
        self.userToEdit = user
        self.view = view
    }
    
    func getUser() {
        view?.setupTextFields()
    }
    
//    var userToEdit = User()
    
    func updateUser(_ user: User, newName: String?, date: String?, gender: String?) {
        dataManager?.updateUser(user, newName: newName, date: date, gender: gender)
    }
    
    
}
