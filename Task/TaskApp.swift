//
//  TaskApp.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI
import UserNotifications

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
                .onAppear {
                    requestNotificationPermission()
                }
        }
    }
    
    private func requestNotificationPermission() {
        // Запрашиваем разрешение на отправку уведомлений
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Ошибка разрешения уведомлений: \(error)")
            } else if granted {
                print("Уведомления разрешены")
                scheduleNotification()
            } else {
                print("Уведомления не разрешены")
            }
        }
    }
    
    private func scheduleNotification() {
        // Создаем и настраиваем содержимое уведомления
        let content = UNMutableNotificationContent()
        content.title = "Осталось задачи"
        content.body = "У вас осталось не выполненных задач"
        content.sound = .default
        
        // Создаем триггер для задержки в одну минуту
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        // Создаем запрос на отправку уведомления
        let request = UNNotificationRequest(identifier: "TaskReminder", content: content, trigger: trigger)
        
        // Отправляем запрос на отправку уведомления
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка отправки уведомления: \(error)")
            } else {
                print("Уведомление успешно запланировано")
            }
        }
    }
}
