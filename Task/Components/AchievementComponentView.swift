//
//  AchievementComponentView.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//

import SwiftUI

struct AchievementComponentView: View {
    @EnvironmentObject private var taskManager: TaskManagerModel
    var achievements: Achievement
    
    var body: some View {
        VStack {
            Image(achievements.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 90)
            
            Text(achievements.title)
            Text(achievements.date)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.gray).opacity(0.9)
        }
    }
}

struct AchievementComponentView_Previews: PreviewProvider {
    static var previews: some View {
        let achievement = Achievement(title: "Новичок", date: "1/08/2023", image: "1")
        AchievementComponentView(achievements: achievement)
           .environmentObject(TaskManagerModel())
    }
}

