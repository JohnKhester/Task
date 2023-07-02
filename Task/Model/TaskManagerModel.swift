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
    var image: String
    let colorImage: String
    let achivmentDescription: String
    let isLockedDescription: String
    let isUnLockedDecription: String
    var isUnlocked: Bool = false
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
        loadAchievementStatus(context: context) // Load achievement status from Core Data
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

    // MARK: Getting Object Of TargetData
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
        
        if task.isDone {
            completedTaskCount += 1
            var achievement = achievements[completedTaskCount - 1]
            achievement.isUnlocked = true
            saveAchievementStatus(achievement: achievement, context: context)
        }
    }


    // MARK: Achievement List
    @Published var achievements: [Achievement] = [
        Achievement(
            title: "Beginner",
            date: "1/08/2023",
            image: "1",
            colorImage: "colorful_1",
            achivmentDescription: "10 Tasks",
            isLockedDescription: "Close your first 10 tasks and start your journey towards achieving your goals.",
            isUnLockedDecription:"You have closed your first 10 tasks and started your journey towards achieving your goals.",
            isUnlocked: false),
                    
        Achievement(
            title: "Active",
            date: "2/08/2023",
            image: "2",
            colorImage: "colorful_2",
            achivmentDescription: "25 Tasks",
            isLockedDescription: "Close 25 tasks to unlock and keep moving forward.",
            isUnLockedDecription: "You have closed 25 tasks and continue to move forward.",
            isUnlocked: false),
        
        Achievement(
            title: "Scout",
            date: "3/08/2023",
            image: "3",
            colorImage: "colorful_3",
            achivmentDescription: "70 Tasks",
            isLockedDescription: "Close 70 tasks and strive towards achieving your goals.",
            isUnLockedDecription: "You have closed 70 tasks, demonstrating your perseverance and constant goal pursuit",
            isUnlocked: false),
        
        Achievement(
            title: "Seeker",
            date: "3/08/2023",
            image: "4",
            colorImage: "colorful_4",
            achivmentDescription: "100 Tasks",
            isLockedDescription: "Close 100 tasks and continue confidently towards your goals.",
            isUnLockedDecription: "You have closed 100 tasks and continue confidently towards your goals. Your perseverance and dedication are admirable!",
            isUnlocked: false),
        
        Achievement(
            title: "Dweller",
            date: "3/08/2023",
            image: "5",
            colorImage: "colorful_5",
            achivmentDescription: "125 Tasks",
            isLockedDescription: "Close 120 tasks and keep conquering new heights",
            isUnLockedDecription: "You have closed 125 tasks and continue to conquer new heights. Your persistent effort and self-discipline are impressive!",
            isUnlocked: false),
        
        Achievement(
            title: "Jedi",
            date: "3/08/2023",
            image: "6",
            colorImage: "colorful_6",
            achivmentDescription: "150 Tasks",
            isLockedDescription: "Close 150 tasks and continue confidently towards your goals.",
            isUnLockedDecription: "You have closed 150 tasks. Your consistency and willpower serve as an example to other AchievoTasks users",
            isUnlocked: false),
    ]

    private var achievementTargets: [String: Int] = [
        "Default": 0,
        "Beginner": 1,
        "Active": 2,
        "Scout": 3,
        "Seeker": 4,
        "Dweller": 5,
        "Jedi": 7
    ]
    
    
    // MARK: Save Achievement Status to CoreData
    func saveAchievementStatus(achievement: Achievement, context: NSManagedObjectContext) {
        guard let achievementIndex = achievements.firstIndex(where: { $0.title == achievement.title }) else {
            return
        }
        
        let isUnlocked = completedTaskCount >= achievementTargets[achievement.title] ?? 0
        
        achievements[achievementIndex].isUnlocked = isUnlocked
        achievements[achievementIndex].image = isUnlocked ? achievements[achievementIndex].colorImage : "default"
        
        saveAchievementStatusToCoreData(achievementID: achievements[achievementIndex].id, isUnlocked: isUnlocked, context: context)
        
        if isUnlocked {
            print("Получено достижение: \(achievement.title)")
        } else {
            print("Доступное достижение: \(achievement.title)")
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }

    // MARK: Save Achievement Status to CoreData
    func saveAchievementStatusToCoreData(achievementID: UUID, isUnlocked: Bool, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<AchievementData> = AchievementData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", achievementID as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if let achievementData = results.first {
                achievementData.isUnlocked = isUnlocked
            } else {
                let newAchievementData = AchievementData(context: context)
                newAchievementData.id = achievementID
                newAchievementData.isUnlocked = isUnlocked
            }
            
            try context.save()
        } catch {
            print("Error saving achievement status to Core Data: \(error.localizedDescription)")
        }
    }

    // MARK: Load Achievement Status from CoreData
    func loadAchievementStatus(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<AchievementData> = AchievementData.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for achievementData in results {
                if let achievementIndex = achievements.firstIndex(where: { $0.id == achievementData.id }) {
                    achievements[achievementIndex].isUnlocked = achievementData.isUnlocked
                    
                    if achievementData.isUnlocked {
                        achievements[achievementIndex].image = achievements[achievementIndex].colorImage
                    }
                }
            }
        } catch {
            print("Error loading achievement status from Core Data: \(error.localizedDescription)")
        }
    }


    func increment() {
        goalCount += 1
    }
    
    func decrement() {
        goalCount -= 1
    }

}
