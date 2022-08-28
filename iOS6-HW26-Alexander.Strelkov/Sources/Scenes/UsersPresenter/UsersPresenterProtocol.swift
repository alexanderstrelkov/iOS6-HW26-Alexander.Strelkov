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
    init(coreDataService: UserDataProtocol)
    func createNewUser(named title: String)
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> { get }
}

class UsersPresenter: UsersPresenterProcotol {
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: UserDataManager.instance.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    
    let dataManager: UserDataProtocol?
    
    required init(coreDataService: UserDataProtocol) {
        self.dataManager = coreDataService
    }
    
    func createNewUser(named title: String) {
        dataManager?.createNewUser(named: title)
    }
}


