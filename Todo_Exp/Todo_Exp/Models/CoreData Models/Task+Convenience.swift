//
//  Task.swift
//  Todo_Exp
//
//  Created by Shak Feizi on 11/5/21.
//

import CoreData


extension Task {
    @discardableResult convenience init(title: String, priority: String, isFavorite: Bool = false, dateCreated: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.priority = priority
        self.isFavorite = isFavorite
        self.dateCreated = dateCreated
    }
}

