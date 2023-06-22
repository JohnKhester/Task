//
//  WidgetComponentView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct WidgetComponentView: View {
    @EnvironmentObject private var taskManager: TaskManagerModel
    @State private var progress: CGFloat = 0.5
    
    var body: some View {
        HStack {
            VStack {
                Text("Задачи")
                Text("\(taskManager.completedTasksCount)/ \(taskManager.totalTasksCount)")
            }
            VStack {
                Text(taskManager.titleTarget)
                Text("\(taskManager.savedTargetCount)")
            }
            Spacer()
            CircularCharView(progress: taskManager.completionPercentage)
                .frame(height: 100)
                .frame(width: 70, height: 70)
                .padding()
                .animation(.linear(duration: 1.0), value: UUID())
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .background {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.ultraThinMaterial).opacity(0.5)
        }
         
    }
}

struct WidgetComponentView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetComponentView()
            .environmentObject(TaskManagerModel())
    }
}
