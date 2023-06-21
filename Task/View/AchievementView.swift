//
//  AchievementView.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//

import SwiftUI

struct AchievementView: View {
    @EnvironmentObject private var taskManager: TaskManagerModel
    var threeColumnGrid = [GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6)]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: threeColumnGrid, spacing: 6) {
                ForEach(taskManager.achievements) { achievement in
                    AchievementComponentView(achievements: achievement)
                }
            }
        }
    }
}

struct AchievementView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementView()
            .environmentObject(TaskManagerModel())
    }
}
