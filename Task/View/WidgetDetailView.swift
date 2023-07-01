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
    @FetchRequest(sortDescriptors: []) private var tasksItems: FetchedResults<TaskData>
    
    var twoColumnGrid = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 6)]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading) {
                        LazyVGrid(columns: twoColumnGrid, spacing: 6) {
                            ActivityBlock(color: .greenColor, title: "All Task", count: tasksItems.count)
                            
                            ActivityBlock(color: .blueColor, title: "Completed Task", count: taskManager.completedTaskCount)
                        }
                        .padding(.bottom, 16)
                        
                        ChangeTargetButtonView()
                    }
                }.padding([.leading, .trailing], 16)
            }
        }.navigationTitle("Activity")
    }
}

struct WidgetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetDetailView()
            .environmentObject(TaskManagerModel())
    }
}

