//
//  AchievementComponentView.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//

import SwiftUI

struct AchievementComponentView: View {
    @EnvironmentObject private var taskManager: TaskManagerModel
    var achievement: Achievement

    var body: some View {
        VStack {
            VStack {
                // Используйте свойство isUnlocked достижения
                if achievement.isUnlocked {
                    Image(achievement.colorImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90, height: 90)
                } else {
                    Image(achievement.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.5)
                        .frame(width: 90, height: 90)
                }
                Text(achievement.title)
                    .mediumFont_13()
                    .foregroundColor(Color.white)
                //Text(achievement.date)
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .id(achievement.id) // Добавляем идентификатор для обновления представления
    }
}

struct AchievementComponentView_Previews: PreviewProvider {
    static var previews: some View {
        let achievement = Achievement(
            title: "Beginner",
            date: "1/08/2023",
            image: "1",
            colorImage: "colorful_1",
            achivmentDescription: "10 Tasks",
            isLockedDescription: "Close your first 10 tasks and start your journey towards achieving your goals.",
            isUnLockedDecription:"You have closed your first 10 tasks and started your journey towards achieving your goals.",
            isUnlocked: false)
        AchievementComponentView(achievement: achievement)
           .environmentObject(TaskManagerModel())
    }
}

 
