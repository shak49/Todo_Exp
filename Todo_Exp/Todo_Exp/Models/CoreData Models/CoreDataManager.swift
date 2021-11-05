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
    var tasks: [Task] = []
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // SHAK: Functions
    func createTask(title: String, priority: String, isFavorite: Bool, dateCreated: Date) {
        let newTask = Task(title: title, priority: priority, isFavorite: isFavorite, dateCreated: dateCreated)
        tasks.append(newTask)
        CoreDataStack.saveContext()
    }
    
    func readTask() {
        let task = try? CoreDataStack.context.fetch(fetchRequest)
    }
    
    func updateTask(task: Task) {
        CoreDataStack.saveContext()
    }
    
    func deleteTask(task: Task) {
        CoreDataStack.context.delete(task)
        CoreDataStack.saveContext()
    }
}
