//
//  ContentView.swift
//  Todo_Exp
//
//  Created by Shak Feizi on 11/4/21.
//

import SwiftUI


enum Priority: String, Identifiable, CaseIterable {
    var id: UUID {
        return UUID()
    }
    
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

extension Priority {
    switch self {
    case .high:
        return "High"
    case .medium:
        return "Medium"
    case .low:
        return "Low"
    }
}


struct ContentView: View {
    @State private var title: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter a title...", text: $title)
            }
            .navigationTitle("To Do")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
