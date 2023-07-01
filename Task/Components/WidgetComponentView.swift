//
//  WidgetComponentView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct WidgetComponentView: View {
    @EnvironmentObject private var taskManager: TaskManagerModel
    @FetchRequest(sortDescriptors: []) private var tasksItems: FetchedResults<TaskData>
    @State private var progress: CGFloat = 0.0

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.red)
                            .frame(width: 8, height: 8)
                        Text("Total Comp. Tasks")
                            .font(Font.system(size: 14))
                            .foregroundColor(Color.white)
                    }
                    Text("\(taskManager.completedTasksCount)")
                        .boldFont_32()
                        .foregroundColor(Color.white)
                        .padding(.top, -8)
                }
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.greenColor)
                                .frame(width: 8, height: 8)
                            Text("Tasks")
                                .font(Font.system(size: 14))
                                .foregroundColor(Color.white)
                        }
                        Text("\(taskManager.completedTasksCount)/\(tasksItems.count)")
                            .boldFont_18()
                            .foregroundColor(Color.white)
                            .padding(.top, -8)
                    }
                    .padding(.trailing, 18)
                    VStack(alignment: .leading) {
                        HStack {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Color.blueColor)
                                .frame(width: 8, height: 8)
                            Text(taskManager.titleTarget)
                                .font(Font.system(size: 14))
                                .foregroundColor(Color.white)
                        }
                        Text("\(taskManager.savedTargetCount)")
                            .boldFont_18()
                            .foregroundColor(Color.white)
                            .padding(.top, -8)
                    }
                }
            }
            Spacer()
            ZStack {
                Text(String(format: "%.0f%%", progress * 100))
                    .boldFont_16()
                    .foregroundColor(Color.white)
                CircularCharView(progress: progress, startColor: .blueColor, endColor: .greenColor)
                    .frame(width: 120, height: 120)
                    .animation(.easeInOut(duration: 1), value: UUID())
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                progress = taskManager.completionPercentage
                            }
                        }
                    }
            }
            .padding(.trailing, 8)
        }
        .padding(18)
        .frame(maxWidth: .infinity)
        .frame(height: 170)
        .background(
            RoundedRectangle(cornerRadius: .cornerRadius, style: .continuous)
                .fill(Color.darkColor)
        )
        
    }
}

struct WidgetComponentView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetComponentView()
            .environmentObject(TaskManagerModel())
    }
}
