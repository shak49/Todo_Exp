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
    func saveTask(title: String, selectedPriority: Priority) {
        CoreDataManager.shared.createTask(title: title, priority: selectedPriority.rawValue, dateCreated: Date())
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
    
    func updateTask(_ task: Task) {
        CoreDataManager.shared.updateTask(task: task)
    }
    
    func deleteTask(at offsets: IndexSet, task: Task) {
        offsets.forEach { index in
            CoreDataManager.shared.deleteTask(task: task)
        }
    }
}
