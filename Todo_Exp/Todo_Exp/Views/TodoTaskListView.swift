//
//  ContentView.swift
//  Todo_Exp
//
//  Created by Shak Feizi on 11/4/21.
//

import SwiftUI
import CoreData


struct TodoTaskListView: View {
    @StateObject private var todoListVM = TodoTaskListVM()
    @State private var title: String = ""
    @State private var selectedPriority: Priority = .medium
    //@Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var allTasks: FetchedResults<Task>
    
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
                    todoListVM.saveTask(title: title, selectedPriority: selectedPriority)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                List {
                    ForEach(CoreDataManager.shared.tasks, id: \.self) { task in
                        HStack {
                            Circle()
                                .fill(todoListVM.priorityStyle(task.priority!))
                                .frame(width: 15, height: 15)
                            Spacer().frame(width: 20)
                            Text(task.title ?? "")
                            Spacer()
                            Image(systemName: task.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                                .onTapGesture {
                                    todoListVM.updateTask(task)
                                }
                        }
                    }
                    //.onDelete(perform: todoListVM.deleteTask)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("To Do")
            .onAppear {
                todoListVM.readTask()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoTaskListView()
    }
}
