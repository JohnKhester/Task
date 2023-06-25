//
//  WidgetDetailView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI


import SwiftUI

struct WidgetDetailView: View {
    @EnvironmentObject private var taskManager: TaskManagerModel
    
    var twoColumnGrid = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 6)]
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 32) {
                    HStack {
                        Text("Activity")
                            .boldFont_32()
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.leading, 12)
                    
                    LazyVGrid(columns: twoColumnGrid, spacing: 6) {
                        ActivityBlock(color: .greenColor, title: "All Task", count: taskManager.totalTasksCount)
                        
                        ActivityBlock(color: .blueColor, title: "All Goal", count: taskManager.completedTasksCount)
                    }
                    .padding(.bottom, 6)
                    
                    ChangeTargetButtonView()
                }
            }.padding([.leading, .trailing], 16)
        }
    }
}

struct WidgetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetDetailView()
            .environmentObject(TaskManagerModel())
    }
}

