//
//  User+CoreDataClass.swift
//  iOS6-HW26-Alexander.Strelkov
//
//  Created by Alexandr Strelkov on 21.08.2022.
//
//

import Foundation
import CoreData

public class User: NSManagedObject {
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var gender: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    convenience init() {
        self.init(entity: UserDataManager.instance.entityForName(entityName: "User"), insertInto: UserDataManager.instance.context)
    }
}
