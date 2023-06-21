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
        Achievement(title: "Эксперт2", date: "3/08/2023", image: "3"),
        Achievement(title: "Эксперт3", date: "3/08/2023", image: "2"),
        Achievement(title: "Эксперт4", date: "3/08/2023", image: "1"),        
    ]
    
    var totalTasksCount: Int {
        tasks.count
    }
    
//    var completedTasksCount: Int {
//        tasks.filter { $0.isDone }.count
//    }

    var completedTasksCount: Int {
        // Шаг 1: Создаем счетчик выполненных задач
        var count = 0
        // Шаг 2: Проходим по каждой задаче в массиве tasks
        for task in tasks {
            // Шаг 3: Проверяем свойство isDone каждой задачи
            if task.isDone {
                // Шаг 4: Если задача выполнена, увеличиваем счетчик на 1
                count += 1
            }
        }
        // Шаг 5: Возвращаем итоговое количество выполненных задач
        return count
    }

    
    func addTask(title: String) {
        let newTask = Task(title: title)
        tasks.append(newTask)
    }
    
    func deleteTask(_ task: Task) {
        var indexToRemove: Int?
        // Шаг 1: Ищем индекс задачи в массиве tasks
        for (index, existingTask) in tasks.enumerated() {
            if existingTask.id == task.id {
                indexToRemove = index
                break
            }
        }
        // Шаг 2: Если задача найдена, удаляем ее из массива tasks
        if let index = indexToRemove {
            tasks.remove(at: index)
        }
    }

    func toggleTaskDone(_ task: Task) {
        for (index, currentTask) in tasks.enumerated() {
            if currentTask.id == task.id {
                tasks[index].isDone.toggle()
                break
            }
        }
    }
    
    // Логика изменение цели
    func increment() {
        targetCount += 1
    }
    
    func dicrement() {
        targetCount -= 1
    }

}
