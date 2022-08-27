//
//  UserDataManager.swift
//  iOS6-HW26-Alexander.Strelkov
//
//  Created by Alexandr Strelkov on 20.08.2022.
//

import Foundation
import CoreData
import UIKit

protocol UserDataProtocol: AnyObject {
//    var allUsers: [User]? { get }
//    func getAllUsers() -> [User]?
    func entityForName(entityName: String) -> NSEntityDescription
    func updateUser(_ user: User, newName: String?, date: String?, gender: String?)
    func createNewUser(named title: String)
}

class UserDataManager: UserDataProtocol {
    
    static let instance = UserDataManager()
    
//    var allUsers: [User]? {
//        return getAllUsers()
//    }
    
//    func getAllUsers() -> [User]? {
//        do {
//            let request = User.fetchRequest() as NSFetchRequest<User>
//            let sort = NSSortDescriptor(key: "name", ascending: true)
//            request.sortDescriptors = [sort]
//            let users = try context.fetch(request)
//            return users
//        } catch {
//            print(error)
//            return nil
//        }
//    }
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
//    lazy var context = persistentContainer.viewContext
    
    //MARK: -EntityDescription
    
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context) ?? NSEntityDescription()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UsersDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //MARK: -Functions:
    
    func updateUser(_ user: User, newName: String?, date: String?, gender: String?) {
        if let newName = newName {
            user.title = newName
        }
        if let date = date {
            user.date = date.convertToDate()
        }
        if let gender = gender {
            user.gender = gender
        }
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func createNewUser(named title: String) {
        let newUser = User(context: context)
        newUser.title = title

        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

extension UserDataManager {
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

