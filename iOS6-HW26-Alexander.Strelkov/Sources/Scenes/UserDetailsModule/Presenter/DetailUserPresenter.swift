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
    
    init(view: DetailUserViewProtocol, user: User?)
    func updateUser(_ user: User, newName: String?, date: String?, gender: String?)
}

class DetailUserPresenter: DetailUserPresenterProtocol {
    weak var view: DetailUserViewProtocol?
    public let dataManager = UserDataManager()
    var userToEdit: User?
    
    required init(view: DetailUserViewProtocol, user: User?) {
        self.userToEdit = user
        self.view = view
    }
    
    func updateUser(_ user: User, newName: String?, date: String?, gender: String?) {
        dataManager.updateUser(user, newName: newName, date: date, gender: gender)
    }
}
