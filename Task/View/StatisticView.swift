//
//  StatisticView.swift
//  Task
//
//  Created by Andrey on 22.06.2023.
//

import SwiftUI



struct StatisticView: View {
    @EnvironmentObject private var taskManager: TaskManagerModel
    @State private var progress: CGFloat = 0.0
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.black.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack {
                        Spacer(minLength: Constants.navigationBarHeight)
                            .frame(width: geometry.size.width, height: Constants.navigationBarHeight, alignment: .top)
                        Text("\(taskManager.completedTaskCount)")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        Text("Общее количество выполненных задач:")
                            .foregroundColor(.white)
                        
                        Text("\(calculateTotalAchievedGoals())")
                             .font(.largeTitle)
                             .foregroundColor(.white)
                         Text("Всего выполнено целей за все время")
                            .foregroundColor(.white)
                    }
                }
                self.createNavigationBar(geometry.size)
            }
        }
    }
    
    private func calculateTotalAchievedGoals() -> Int {
        var totalAchievedGoals = 0
        for achievement in taskManager.achievements {
            if taskManager.achievementStatus[achievement.id] == true {
                totalAchievedGoals += 1
            }
        }
        return totalAchievedGoals
    }
    
    func createNavigationBar(_ geometrySize: CGSize) -> some View {
        ZStack(alignment: .top) {
            BlurView(style: .dark).edgesIgnoringSafeArea(.top)
            VStack {
                HStack {
                    ForEach(taskManager.taskProgress.sorted(by: { $0.key < $1.key }), id: \.key) { item in
                        let day = item.key
                        let progress = item.value
                        
                        let completionPercentage = Double(progress.completedCount) / Double(progress.totalCount)
                        
                        VStack(spacing: 5) {
                            Text(day)
                                .font(Font.system(size: 10, weight: .regular, design: .default))
                                .foregroundColor(Color.blue)
                            ZStack {
                                CircularCharView(progress: completionPercentage, startColor: .blue, endColor: .teal)
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                }
            }
        }

        .frame(width: geometrySize.width, height: Constants.navigationBarHeight, alignment: .top)
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
            .environmentObject(TaskManagerModel())
    }
}
