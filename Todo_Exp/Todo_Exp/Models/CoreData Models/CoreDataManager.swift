//
//  CoreDataManager.swift
//  Todo_Exp
//
//  Created by Shak Feizi on 11/5/21.
//

import CoreData


class CoreDataManager {
    // SHAK: Properties
    static let shared: CoreDataManager = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
}
