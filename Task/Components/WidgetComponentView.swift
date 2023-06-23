//
//  WidgetComponentView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct WidgetComponentView: View {
    @EnvironmentObject private var taskManager: TaskManagerModel
//    @Environment(\.colorScheme) var colorScheme
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.red)
                        .frame(width: 8, height: 8)
                    Text("Задачи")
                        .font(Font.system(size: 14))
                        .whiteForegroundWithOpacity()
                }
                Text("\(taskManager.completedTasksCount)/\(taskManager.totalTasksCount)")
                    .boldFont_24()
                    .foregroundColor(Color.white)
            }
            .padding(.trailing, 18)
            VStack(alignment: .leading) {
                HStack {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.teal)
                        .frame(width: 8, height: 8)
                    Text(taskManager.titleTarget)
                        .font(Font.system(size: 14))
                        .whiteForegroundWithOpacity()
                }
                Text("\(taskManager.savedTargetCount)")
                    .boldFont_24()
                    .foregroundColor(Color.white)
            }
            Spacer()
            ZStack {
                Text(String(format: "%.0f%%", progress * 100))
                    .boldFont_16()
                    .foregroundColor(Color.white)
                CircularCharView(progress: progress,  startColor: .blue, endColor: .teal)
                    .frame(width: 80, height: 80)
                    .animation(.easeInOut(duration: 1), value: UUID())
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                progress = taskManager.completionPercentage
                            }
                        }
                 }
            }.padding(.trailing, 8)
        }.padding(18)
        .frame(maxWidth: .infinity)
        .frame(height: 140)
        .background {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.white).opacity(0.07)
        }
        
    }
}



struct WidgetComponentView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetComponentView()
            .environmentObject(TaskManagerModel())
    }
}
