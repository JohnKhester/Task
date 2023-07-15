//
//  CounterTargetComponents.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct CounterTargetComponents: View {
    @EnvironmentObject private var taskManager: TaskManagerModel
    
    // MARK: All Environment Values in one Variable
    @Environment(\.self) var env
    
    // MARK: Fetching Task
    @FetchRequest(entity: TaskData.entity(), sortDescriptors: [], predicate: nil, animation: .easeInOut) var tasksArray: FetchedResults<TaskData>
    
    @State private var isEditingTarget = false
    @State private var hasChangedTarget = false
    @Binding var isChangeTargetActive: Bool

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    if taskManager.goalCount > 0 {
                        decrementTarget()
                    }
                }) {
                    Image(systemName: "minus")
                        .boldFont_16()
                        .foregroundColor((taskManager.goalCount > 0) ? .black : .gray)
                }
                .buttonStyle(TargetButtonStyle(enabled: taskManager.goalCount > 0))
                .padding(.trailing, 20)

                VStack {
                    Text("\(taskManager.goalCount)")
                        .boldFont_32()
                        .foregroundColor(.white)
                    Text("Your Goal")
                        .mediumFont_18()
                        .foregroundColor(.white)
                }

                Button(action: {
                    incrementTarget()
                }) {
                    Image(systemName: "plus")
                        .boldFont_16()
                        .foregroundColor(.black)
                }
                .buttonStyle(TargetButtonStyle(enabled: true))
                .padding(.leading, 20)
            }
            .padding(.bottom, 20)
            .background(Color.background)

            
            Button(action: {
                toggleEditingTarget()
            }) {
                Text("Change Goal")
                    .foregroundColor(hasChangedTarget || taskManager.goalCount == 0 ? .black : .gray)
            }
            .buttonStyle(ChangeGoalButtonStyle(enabled: hasChangedTarget && taskManager.goalCount > 0))
            .frame(maxWidth: .infinity)
            .padding(14)
            .disabled(!hasChangedTarget || taskManager.goalCount == 0)
        }
        .padding(16)
    }

    private func incrementTarget() {
        taskManager.goalCount += 1
        hasChangedTarget = true
    }

    private func decrementTarget() {
        taskManager.goalCount -= 1
        hasChangedTarget = true
    }

    private func toggleEditingTarget() {
        isEditingTarget.toggle()
        if isEditingTarget {
            taskManager.savedTargetCount = Int(taskManager.goalCount)
            if let context = tasksArray.first?.managedObjectContext {
                taskManager.saveGoalData(context: context)
            }
        }
        isChangeTargetActive = isEditingTarget
    }
}

struct TargetButtonStyle: ButtonStyle {
    let enabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 48, height: 48)
            .background {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(enabled ? Color.greenColor : Color.gray.opacity(0.2))
            }
            .disabled(!enabled)
    }
}

struct ChangeGoalButtonStyle: ButtonStyle {
    let enabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(enabled ? .black : .gray)
            .frame(maxWidth: .infinity)
            .padding(14)
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(enabled ? Color.greenColor : Color.gray.opacity(0.2))
            }
    }
}

struct CounterTargetComponents_Previews: PreviewProvider {
    static var previews: some View {
        CounterTargetComponents(isChangeTargetActive: .constant(false))
            .environmentObject(TaskManagerModel())
    }
}
