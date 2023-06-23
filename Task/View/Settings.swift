//
//  Settings.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//

import SwiftUI

struct Settings: View {
    @State private var isChangeTargetActive = false
    var body: some View {
        NavigationStack {
            List {
                Button(action: {
                    self.isChangeTargetActive = true
                }, label: {
                    Text("Изменить цель задач")
                })
                
                Text("Уведомления")
                Text("Конфидициальность")
                Text("Отключить рекламу")
            }.sheet(isPresented: $isChangeTargetActive) {
                VStack {
                    HStack {
                        Button(action: {
                            self.isChangeTargetActive.toggle()
                        }) {
                            Text("Отменить")
                        }
                        Spacer()
                    }
                    VStack {
                        Text("Title")
                            .font(.title)
                        Text("Описание")
                    }.padding(.vertical, 16)
                    CounterTargetComponents(isChangeTargetActive: $isChangeTargetActive)
                }
            }
            .navigationTitle("Настройки")
            .navigationBarTitleDisplayMode(.inline) 
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
            .environmentObject(TaskManagerModel())
    }
}
