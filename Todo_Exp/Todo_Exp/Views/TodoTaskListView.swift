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
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var taskRequest: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a title...", text: $title)
                    .textFieldStyle(.roundedBorder)
                Picker("Priorities", selection: $selectedPriority) {
                    ForEach(Priority.allCases) { priority in
                        Text(priority.description).tag(priority)
                    }
                }
                .pickerStyle(.segmented)
                Button("Save") {
                    todoListVM.saveTask(title: title, selectedPriority: selectedPriority, context: viewContext)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                List {
                    ForEach(taskRequest) { task in
                        Text(task.title ?? "")
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("All Tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoTaskListView()
    }
}
