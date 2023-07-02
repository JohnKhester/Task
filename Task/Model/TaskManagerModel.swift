//
//  TaskManagerModel.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//

import Foundation
import SwiftUI
import CoreData

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let image: String
    let colorImage: String
    let achivmentDescription: String
    let isLockedDescription: String
    let isUnLockedDecription: String
    var isUnlocked: Bool = false
}


struct TaskProgress: Identifiable {
    let id = UUID()
    var completedCount: Int = 0
    var totalCount: Int = 0
}


class TaskManagerModel: ObservableObject, Identifiable {
    
    @FetchRequest(entity: TaskData.entity(), sortDescriptors: [], predicate: nil, animation: .easeInOut) var tasksArray: FetchedResults<TaskData>
    
    // MARK: New Task Properties
    @Published var taskTitle: String = ""
    @Published var taskDeadline: Date = Date()
    @Published var isDone: Bool = false
    @Published var completedTaskCount: Int = 0
    
    // MARK: New Target Properties
    @Published var goalCount: Int16 = 0
    @Published var savedTargetCount: Int = 0
    
    
    // MARK: New initializer to load goal count from Core Data
    init() {
        let context = PersistenceController.shared.container.viewContext
        loadGoalCount(context: context)
    }
    // MARK: Save Target Count To Core Data
    func saveGoalCount(context: NSManagedObjectContext) {
        if let targetData = fetchTargetData(context: context) {
            targetData.targetCount = Int16(goalCount)
        } else {
            let newTargetData = TargetData(context: context)
            newTargetData.targetCount = Int16(goalCount)
        }

        do {
            try context.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
    // MARK: Load Saved Value Target Core Data
    func loadGoalCount(context: NSManagedObjectContext) {
        if let targetData = fetchTargetData(context: context) {
            goalCount = Int16(targetData.targetCount)
        } else {
            goalCount = 0
        }
    }
    // Получение объекта TargetData
    private func fetchTargetData(context: NSManagedObjectContext) -> TargetData? {
        let fetchRequest: NSFetchRequest<TargetData> = TargetData.fetchRequest()

        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Error fetching target data: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: Adding Task To Core Data
    func addTask(context: NSManagedObjectContext) -> Bool {
        var newTask: TaskData!
        newTask = TaskData(context: context)
        newTask.titleTask = taskTitle
        newTask.deadline = taskDeadline
        newTask.id = UUID()
        newTask.isDone = false
        try? context.save()
        context.refreshAllObjects()
        if let _ = try? context.save() {
            return true
        }
        return false
    }
    
    // MARK: Delete Task To Core Data
    func deleteTask(task: TaskData, context: NSManagedObjectContext) {
        context.delete(task)
        try? context.save()
       
    }

    // MARK: Completed Task To Core Data
    func toggleTaskDone(task: TaskData, context: NSManagedObjectContext) {
        task.isDone.toggle()
        try? context.save()
    }
    
    
    @Published var achievements: [Achievement] = [
        Achievement(
            title: "Beginner",
            date: "1/08/2023",
            image: "1",
            colorImage: "colorful_1",
            achivmentDescription: "10 Tasks",
            isLockedDescription: "Close your first 10 tasks and start your journey towards achieving your goals.",
            isUnLockedDecription:"You have closed your first 10 tasks and started your journey towards achieving your goals."),
        
        Achievement(
            title: "Active",
            date: "2/08/2023",
            image: "2",
            colorImage: "colorful_2",
            achivmentDescription: "25 Tasks",
            isLockedDescription: "Close 25 tasks to unlock and keep moving forward.",
            isUnLockedDecription: "You have closed 25 tasks and continue to move forward."),
        
        Achievement(
            title: "Scout",
            date: "3/08/2023",
            image: "3",
            colorImage: "colorful_3",
            achivmentDescription: "70 Tasks",
            isLockedDescription: "Close 70 tasks and strive towards achieving your goals.",
            isUnLockedDecription: "You have closed 70 tasks, demonstrating your perseverance and constant goal pursuit"),
        
        Achievement(
            title: "Seeker",
            date: "3/08/2023",
            image: "4",
            colorImage: "colorful_4",
            achivmentDescription: "100 Tasks",
            isLockedDescription: "Close 100 tasks and continue confidently towards your goals.",
            isUnLockedDecription: "You have closed 100 tasks and continue confidently towards your goals. Your perseverance and dedication are admirable!"),
        
        Achievement(
            title: "Dweller",
            date: "3/08/2023",
            image: "5",
            colorImage: "colorful_5",
            achivmentDescription: "125 Tasks",
            isLockedDescription: "Close 120 tasks and keep conquering new heights",
            isUnLockedDecription: "You have closed 125 tasks and continue to conquer new heights. Your persistent effort and self-discipline are impressive!"),
        
        Achievement(
            title: "Jedi",
            date: "3/08/2023",
            image: "6",
            colorImage: "colorful_6",
            achivmentDescription: "150 Tasks",
            isLockedDescription: "Close 150 tasks and continue confidently towards your goals.",
            isUnLockedDecription: "You have closed 150 tasks. Your consistency and willpower serve as an example to other AchievoTasks users"),
        //Achievement(title: "Default", date: "", image: "default", colorImage: "colorful_default")
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


//    // Вычисление общего прогресса выполнения задач для всех дней
//    var overallProgress: Double {
//        let totalCompletedCount = taskProgress.values.reduce(0) { $0 + $1.completedCount }
//        let totalTaskCount = taskProgress.values.reduce(0) { $0 + $1.totalCount }
//        if totalTaskCount == 0 {
//            return 0.0
//        } else {
//            return Double(totalCompletedCount) / Double(totalTaskCount)
//        }
//    }
//    
//    // функция обновляет прогресс выполнения задачи для указанного дня, основываясь на значении completedTasksCount.
//    func updateTaskProgress(forDay day: String) {
//        if let progress = taskProgress[day] {
//            var updatedProgress = progress
//            updatedProgress.completedCount = completedTasksCount
//            taskProgress[day] = updatedProgress
//        }
//    }

    private var achievementTargets: [String: Int] = [
        "Default": 0,
        "Beginner": 1,
        "Active": 2,
        "Scout": 3,
        "Seeker": 4,
        "Dweller": 5,
        "Jedi": 7
    ]
    
    
//    func toggleTaskDone(_ task: Task) {
//        for (index, currentTask) in tasksItems.enumerated() {
//            if currentTask.id == task.id {
//                tasksItems[index].isDone.toggle()
//
//                let completedCount = completedTasksCount
//                let target = targetCount
//
//                if completedCount == target {
//                    // Проверяем, есть ли разблокированные достижения
//                    let unlockedAchievements = achievements.filter { achievement in
//                        let isUnlocked = achievementStatus[achievement.id] ?? false
//                        let achievementTarget = achievementTargets[achievement.title] ?? 0
//                        return !isUnlocked && achievementTarget == target
//                    }
//
//                    // Разблокируем достижия, соответствующие установленной цели
//                    for unlockedAchievement in unlockedAchievements {
//                        achievementStatus[unlockedAchievement.id] = true
//                        print("Achievement unlocked: \(unlockedAchievement.title)")
//                    }
//                }
//                break
//            }
//        }
//        // После завершения цикла обновляем isUnlocked в объектах достижений
//        for (index, achievement) in achievements.enumerated() {
//            let achievementTarget = achievementTargets[achievement.title] ?? 0
//            let isUnlocked = achievementStatus[achievement.id] ?? false || completedTasksCount >= achievementTarget
//            achievements[index].isUnlocked = isUnlocked
//        }
//
////        // После завершения цикла обновляем isUnlocked в объектах достижений
////        for (index, achievement) in achievements.enumerated() {
////            let achievementTarget = achievementTargets[achievement.title] ?? 0
////            let isUnlocked = achievementStatus[achievement.id] ?? false || (completedTasksCount >= achievementTarget && achievementTarget == targetCount)
////            achievements[index].isUnlocked = isUnlocked
////        }
//
//    }

    func increment() {
        goalCount += 1
    }
    
    func decrement() {
        goalCount -= 1
    }

}
