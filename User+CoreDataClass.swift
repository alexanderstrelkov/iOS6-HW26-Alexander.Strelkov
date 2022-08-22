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
    convenience init() {
        self.init(entity: UserDataManager.instance.entityForName(entityName: "User"), insertInto: UserDataManager.instance.context)
    }

}
