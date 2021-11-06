//
//  Todo_ExpApp.swift
//  Todo_Exp
//
//  Created by Shak Feizi on 11/4/21.
//

import SwiftUI
import CoreData

@main
struct Todo_ExpApp: App {
    let coreDataManager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            TodoTaskListView().environment(\.managedObjectContext, coreDataManager.persistentContainer.viewContext)
        }
    }
}
