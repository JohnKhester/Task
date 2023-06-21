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
    var body: some Scene {
        WindowGroup {
            Activity()
                .environmentObject(taskManager)
              //  .preferredColorScheme(.dark)
        }
    }
}
