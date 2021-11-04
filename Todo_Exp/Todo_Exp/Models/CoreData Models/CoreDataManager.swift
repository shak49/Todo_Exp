//
//  CoreDataManager.swift
//  Todo_Exp
//
//  Created by Shak Feizi on 11/4/21.
//

import Foundation
import CoreData


class CoreDataManager {
    // SHAK: Properties
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    // SHAK: Initializers
    private init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data: \(error)")
            }
        }
    }
}
