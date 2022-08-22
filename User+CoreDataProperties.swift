//
//  User+CoreDataProperties.swift
//  iOS6-HW26-Alexander.Strelkov
//
//  Created by Alexandr Strelkov on 21.08.2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var title: String?
    @NSManaged public var avatar: Data?
    @NSManaged public var date: Date?
    @NSManaged public var gender: String?

}

extension User : Identifiable {

}
