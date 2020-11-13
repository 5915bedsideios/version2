//
//  User+CoreDataProperties.swift
//  BedSide Chats
//
//  Created by Jack Wu on 11/14/20.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?

}
