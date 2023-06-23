//
//  TaskManagerModel.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//

import Foundation
import SwiftUI
import Combine

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isDone: Bool = false
}

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let image: String
    var isUnlocked: Bool = false
}


struct TaskProgress: Identifiable {
    let id = UUID()
    var completedCount: Int = 0
    var totalCount: Int = 0
}


class TaskManagerModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var titleTarget: String = "Цель"
    @Published var targetCount: Int = 3 // Цель пользователя
    @Published var savedTargetCount: Int = 3
    @Published var achievements: [Achievement] = [
        Achievement(title: "Новичок", date: "1/08/2023", image: "1"),
        Achievement(title: "Продвинутый", date: "2/08/2023", image: "2"),
        Achievement(title: "Эксперт", date: "3/08/2023", image: "3"),
        Achievement(title: "Эксперт2", date: "3/08/2023", image: "4"),
        Achievement(title: "Эксперт3", date: "3/08/2023", image: "5"),
        Achievement(title: "Эксперт4", date: "3/08/2023", image: "6"),
        Achievement(title: "Default", date: "", image: "default")
    ]
    // Добавляем словарь для хранения статуса разблокировки каждого достижения
    @Published var achievementStatus: [UUID: Bool] = [:]
    
    @Published var taskProgress: [String: TaskProgress] = [
        "M": TaskProgress(completedCount: 0, totalCount: 0),
        "Tu": TaskProgress(completedCount: 0, totalCount: 0),
        "W": TaskProgress(completedCount: 0, totalCount: 0),
        "Th": TaskProgress(completedCount: 0, totalCount: 0),
        "F": TaskProgress(completedCount: 0, totalCount: 0),
        "Sa": TaskProgress(completedCount: 0, totalCount: 0),
        "Su": TaskProgress(completedCount: 0, totalCount: 0)
    ]


    // Вычисление общего прогресса выполнения задач для всех дней
    var overallProgress: Double {
        let totalCompletedCount = taskProgress.values.reduce(0) { $0 + $1.completedCount }
        let totalTaskCount = taskProgress.values.reduce(0) { $0 + $1.totalCount }
        if totalTaskCount == 0 {
            return 0.0
        } else {
            return Double(totalCompletedCount) / Double(totalTaskCount)
        }
    }
    // Function to update the progress for a specific day
    func updateTaskProgress(forDay day: String) {
        if let progress = taskProgress[day] {
            var updatedProgress = progress
            updatedProgress.completedCount = completedTasksCount
            taskProgress[day] = updatedProgress
        }
    }
    
    
    
    private var achievementTargets: [String: Int] = [
        "Default": 0,
        "Новичок": 3,
        "Продвинутый": 5, // Замените значение на 5
        "Эксперт": 6,
        "Эксперт2": 7,
        "Эксперт3": 8,
        "Эксперт4": 9
    ]
    
    var totalTasksCount: Int {
        tasks.count
    }
    var completedTasksCount: Int {
        var count = 0
        for task in tasks {
            if task.isDone {
                count += 1
            }
        }
        return count
    }

    
    func addTask(title: String) {
        let newTask = Task(title: title)
        tasks.append(newTask)
    }
    
    func deleteTask(_ task: Task) {
        var indexToRemove: Int?
        for (index, existingTask) in tasks.enumerated() {
            if existingTask.id == task.id {
                indexToRemove = index
                break
            }
        }
        if let index = indexToRemove {
            tasks.remove(at: index)
        }
    }

    
    func toggleTaskDone(_ task: Task) {
        for (index, currentTask) in tasks.enumerated() {
            if currentTask.id == task.id {
                tasks[index].isDone.toggle()
                
                let completedCount = completedTasksCount
                let target = targetCount
                
                if completedCount == target {
                    // Проверяем, есть ли разблокированные достижения
                    let unlockedAchievements = achievements.filter { achievement in
                        let isUnlocked = achievementStatus[achievement.id] ?? false
                        let achievementTarget = achievementTargets[achievement.title] ?? 0
                        return !isUnlocked && achievementTarget == target
                    }
                    
                    // Разблокируем достижия, соответствующие установленной цели
                    for unlockedAchievement in unlockedAchievements {
                        achievementStatus[unlockedAchievement.id] = true
                        print("Achievement unlocked: \(unlockedAchievement.title)")
                    }
                }
                break
            }
        }
        // После завершения цикла обновляем isUnlocked в объектах достижений
        for (index, achievement) in achievements.enumerated() {
            let achievementTarget = achievementTargets[achievement.title] ?? 0
            let isUnlocked = achievementStatus[achievement.id] ?? false || completedTasksCount >= achievementTarget
            achievements[index].isUnlocked = isUnlocked
        }
        
//        // После завершения цикла обновляем isUnlocked в объектах достижений
//        for (index, achievement) in achievements.enumerated() {
//            let achievementTarget = achievementTargets[achievement.title] ?? 0
//            let isUnlocked = achievementStatus[achievement.id] ?? false || (completedTasksCount >= achievementTarget && achievementTarget == targetCount)
//            achievements[index].isUnlocked = isUnlocked
//        }

    }

    // Логика изменение цели
    func increment() {
        targetCount += 1
    }
    
    func dicrement() {
        targetCount -= 1
    }

    var completionPercentage: Double {
        let completedCount = Double(completedTasksCount)
        let target = Double(targetCount)
        
        if target == 0 {
            return 0.0
        } else {
            return completedCount / target
        }
    }
    
    // Статистика всех задач 
    var totalCompletedTasksCount: Int {
          var count = 0
          for task in tasks {
              if task.isDone {
                  count += 1
              }
          }
          return count
      }
    
    // Дата
    func currentDateWithDayFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd/MM/yyyy"
        return dateFormatter.string(from: Date())
    }

}
