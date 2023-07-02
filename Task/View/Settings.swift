//
//  Settings.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//

import SwiftUI
import UserNotifications


struct Settings: View {
    @State private var isChangeTargetActive = false
    @State private var isNotificationEnabled = false
    var body: some View {
        NavigationStack {
            List {
                Button(action: {
                    self.isChangeTargetActive = true
                }, label: {
                    Text("Change Task Goal")
                })
                
                Toggle("Notifications", isOn: $isNotificationEnabled)
                    .onChange(of: isNotificationEnabled) { newValue in
                        if newValue {
                            requestNotificationPermission()
                        } else {
                            cancelNotifications()
                        }
                    }
                
                Text("Privacy")
                Text("ADS ")
            }.sheet(isPresented: $isChangeTargetActive) {
                ZStack {
                    Color.background.ignoresSafeArea(.all)
                VStack {
                    HStack {
                        Button(action: {
                            self.isChangeTargetActive.toggle()
                        }) {
                            Text("Cancel")
                                .foregroundColor(Color.greenColor)
                        }.padding([.leading, .top], 24)
                        Spacer()
                    }
                    Spacer()
                    VStack {
                        Text("Goal Tracker")
                            .boldFont_32()
                            .foregroundColor(.white)
                            .padding(.vertical, 16)
                        Text("Stay motivated and laser-focused on your objectives.Get ready to unlock your full potential and unleash your productivity with Goal Tracker.")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .mediumFont_14()
                            .padding(.horizontal, 30)
                        
                    }.padding(.vertical, 16)
                    CounterTargetComponents(isChangeTargetActive: $isChangeTargetActive)
                    Spacer()
                }
            }
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    private func requestNotificationPermission() {
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
        let content = UNMutableNotificationContent()
        content.title = "Осталось задачи"
        content.body = "У вас осталось не выполненных задач"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        
        let request = UNNotificationRequest(identifier: "TaskReminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка отправки уведомления: \(error)")
            } else {
                print("Уведомление успешно запланировано")
            }
        }
    }
    
    private func cancelNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["TaskReminder"])
    }
}

 
struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
            .environmentObject(TaskManagerModel())
    }
}
