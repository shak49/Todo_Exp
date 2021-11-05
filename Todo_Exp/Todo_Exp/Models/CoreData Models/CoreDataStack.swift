//
//  CoreDataManager.swift
//  Todo_Exp
//
//  Created by Shak Feizi on 11/4/21.
//

import Foundation
import CoreData


enum CoreDataStack {
    // SHAK: Properties
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error loading persistent stores \(error.localizedDescription)")
            }
        }
        return container
    }()
    static var context: NSManagedObjectContext { container.viewContext }
    
    // SHAK: Functions
    static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context \(error)")
            }
        }
    }
}
