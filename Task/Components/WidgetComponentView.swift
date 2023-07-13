//
//  WidgetComponentView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct WidgetComponentView: View {
    @EnvironmentObject private var taskManager: TaskManagerModel
    
    // MARK: All Environment Values in one Variable
    @Environment(\.self) var env
    
    // MARK: Fetching Task
    @FetchRequest(entity: TaskData.entity(), sortDescriptors: [], predicate: nil, animation: .easeInOut) var tasksArray: FetchedResults<TaskData>
    
    @State private var progress: CGFloat = 0.0

    // MARK: Fetching Task Done
    var completedTaskCount: Int { tasksArray.filter { $0.isDone }.count }
    var yesterdayCompletedTasksCount: Int { tasksArray.filter { $0.isDone && Calendar.current.isDateInYesterday($0.doneAt ?? Date()) }.count }
    
    // MARK: Fetching Сompletion Percentage Task
    var completionPercentage: Double {
        let completedCount = Double(completedTaskCount)
        let target = Double(taskManager.goalCount)
        
        if target == 0 {
            return 0.0
        } else {
            return completedCount / target
        }
    }
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
                    Text("\(completedTaskCount)")
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
                        Text("\(completedTaskCount)/\(tasksArray.count)")
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
                            Text("Goal")
                                .font(Font.system(size: 14))
                                .foregroundColor(Color.white)
                        }
                        Text("\(taskManager.goalCount)")
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
                CircularCharView(progress:  CGFloat(completionPercentage), startColor: .blueColor, endColor: .greenColor)
                    .frame(width: 120, height: 120)
                    .animation(.easeInOut(duration: 3), value: UUID())
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                progress = CGFloat(completionPercentage)
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
        .onAppear() {
            print(completedTaskCount)
            print(yesterdayCompletedTasksCount)
        }
    }
}

struct WidgetComponentView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetComponentView()
            .environmentObject(TaskManagerModel())
    }
}
