//
//  ContentView.swift
//  Todo_Exp
//
//  Created by Shak Feizi on 11/4/21.
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


struct ContentView: View {
    @State private var title: String = ""
    @State private var selectedPriority: Priority = .medium
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var allTasks: FetchedResults<Task>
    
    private func saveTask() {
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
    
    private func priorityStyle(_ value: String) -> Color {
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
    
    private func updateTask(_ task: Task) {
        task.isFavorite = !task.isFavorite
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = allTasks[index]
            viewContext.delete(task)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a title...", text: $title)
                    .textFieldStyle(.roundedBorder)
                Picker("Priority", selection: $selectedPriority) {
                    ForEach(Priority.allCases) { priority in
                        Text(priority.description).tag(priority)
                    }
                }
                .pickerStyle(.segmented)
                Button("Save") {
                    saveTask()
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                List {
                    ForEach(allTasks) { task in
                        HStack {
                            Circle()
                                .fill(priorityStyle(task.priority!))
                                .frame(width: 15, height: 15)
                            Spacer().frame(width: 20)
                            Text(task.title ?? "")
                            Spacer()
                            Image(systemName: task.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .onTapGesture {
                                    updateTask(task)
                                }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("To Do")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistentContainer = CoreDataManager.shared.persistentContainer
        ContentView().environment(\.managedObjectContext, persistentContainer.viewContext)
    }
}
