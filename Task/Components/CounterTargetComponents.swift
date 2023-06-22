//
//  CounterTargetComponents.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct CounterTargetComponents: View {
    @EnvironmentObject private var taskManager: TaskManagerModel
    @State private var isEditingTarget = false
    @State private var hasChangedTarget = false
    @Binding var isChangeTargetActive: Bool  // Добавляем привязку состояния
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.taskManager.dicrement()
                    self.hasChangedTarget = true
                }, label: {
                    Image(systemName: "minus")
                }).disabled(taskManager.targetCount == 0)
                
                Text("Цель: \(taskManager.targetCount)")
                
                Button(action: {
                    self.taskManager.increment()
                    self.hasChangedTarget = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
            Button(action: {                
                self.isEditingTarget.toggle()
                if self.isEditingTarget {
                    self.taskManager.savedTargetCount = self.taskManager.targetCount
                }
                self.isChangeTargetActive = false
            }) {
                    Text("Изменить цель")
                
            }.disabled(!hasChangedTarget)
        }
    }
}

struct CounterTargetComponents_Previews: PreviewProvider {
    static var previews: some View {
        CounterTargetComponents(isChangeTargetActive: .constant(false))
            .environmentObject(TaskManagerModel())
    }
}
