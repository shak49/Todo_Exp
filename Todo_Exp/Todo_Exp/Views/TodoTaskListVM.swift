//
//  TodoTaskListVM.swift
//  Todo_Exp
//
//  Created by Shak Feizi on 11/5/21.
//

import SwiftUI
import CoreData


enum Priority: String, Identifiable, CaseIterable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    var id: UUID {
        return UUID()
    }
    
    var description: String {
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
}


class TodoTaskListVM: ObservableObject, Identifiable {
    // SHAK: Properties
    
    // SHAK: Functions
    func priorityStyle(_ value: String) -> Color {
        let priority = Priority(rawValue: value)
        switch priority {
        case .low:
            return Color.green
        case .medium:
            return Color.yellow
        case .high:
            return Color.red
        default:
            return Color.black
        }
    }
    
    func saveTask(title: String, selectedPriority: Priority, context: NSManagedObjectContext) {
        do {
            let task = Task(context: context)
            task.title = title
            task.priority = selectedPriority.rawValue
            task.dateCreated = Date()
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateTask(_ task: Task) {
        
    }
    
    func deleteTask(at offsets: IndexSet, task: Task) {
        offsets.forEach { index in
            
        }
    }
}
