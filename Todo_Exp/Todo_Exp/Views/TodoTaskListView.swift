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
                    
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .border(.blue, width: 3)
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
