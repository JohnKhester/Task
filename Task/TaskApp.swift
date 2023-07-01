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
    @StateObject private var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            Activity()
                .preferredColorScheme(.dark)
                .environmentObject(taskManager)
                .environmentObject(dataManager)
                .environment(\.managedObjectContext, dataManager.container.viewContext)
        }
    }
}

