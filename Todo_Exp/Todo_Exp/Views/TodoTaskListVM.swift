//
//  TodoTaskListVM.swift
//  Todo_Exp
//
//  Created by Shak Feizi on 11/5/21.
//

import SwiftUI
import CoreData


enum Priority: String, Identifiable, CaseIterable {
    var id: UUID {
        return UUID()
    }
    
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

extension Priority {
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
    func saveTask(title: String, selectedPriority: Priority, viewContext: NSManagedObjectContext) {
        do {
            let task = Task(context: viewContext)
            task.title = title
            task.priority = selectedPriority.rawValue
            task.dateCreated = Date()
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
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
    
    func updateTask(_ task: Task, viewContext: NSManagedObjectContext) {
        task.isFavorite = !task.isFavorite
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = allTasks[index]
            viewContext.delete(task)
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
