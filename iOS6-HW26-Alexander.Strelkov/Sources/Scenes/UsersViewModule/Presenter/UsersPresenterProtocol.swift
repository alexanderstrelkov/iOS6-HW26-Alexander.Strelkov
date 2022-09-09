//
//  UsersPresenter.swift
//  iOS6-HW26-Alexander.Strelkov
//
//  Created by Alexandr Strelkov on 25.08.2022.
//

import Foundation
import UIKit
import CoreData

protocol UsersPresenterProcotol: AnyObject {
    func createNewUser(named title: String)
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> { get }
    func loadUsers()
    func deleteUser(user: NSManagedObject)
    func saveUser()
}

class UsersPresenter: UsersPresenterProcotol {
    
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: UserDataManager.instance.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    
    public let dataManager = UserDataManager()
    
    func createNewUser(named title: String) {
        dataManager.createNewUser(named: title)
    }
    
    func loadUsers() {
        do {
            try fetchResultController.performFetch()
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func deleteUser(user: NSManagedObject) {
        fetchResultController.managedObjectContext.delete(user)
        do {
            try fetchResultController.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    func saveUser() {
        
    }
}


