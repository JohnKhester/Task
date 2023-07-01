//
//  TaskApp.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

@main
struct TaskApp: App {
    @StateObject private var taskManager = TaskManagerModel()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Activity()
                .preferredColorScheme(.dark)
                .environmentObject(taskManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

