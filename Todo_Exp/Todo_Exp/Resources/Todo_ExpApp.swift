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
    let container = CoreDataManager.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
            TodoTaskListView().environment(\.managedObjectContext, container.viewContext)
        }
    }
}
