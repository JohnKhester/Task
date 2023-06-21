//
//  ContentView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct HomeView: View {
    // @State private var isDetailViewActive = false
    @EnvironmentObject private var taskManager: TaskManagerModel
    var twoColumnGrid = [GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6)]
    var threeColumnGrid = [GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6)]
    var body: some View {
        NavigationStack {
            ScrollView {
                NavigationLink {
                    WidgetDetailView()
                } label: {
                    WidgetComponentView()
                }
                VStack(spacing: 6.0) {
                    HStack {
                        Text("Сегодня")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(Color.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 4)
                        
                        Spacer()
//                        
//                        Text("Show More")
//                            .font(.callout)
//                            .fontWeight(.regular)
//                            .foregroundColor(Color.blue)
                    }
                }
                LazyVGrid(columns: twoColumnGrid, spacing: 6) {
                    NavigationLink {
                        TaskView()
                    } label: {
                        TodayComponentView()
                    }
                    NavigationLink {
                        ArchiveView()
                    } label: {
                        ArchiveComponentView()
                    }
                }
                VStack(spacing: 6.0) {
                    HStack {
                        Text("Награды")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(Color.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 4)
                        
                        Spacer()
                        NavigationLink {
                            AchievementView()
                        } label: {
                            Text("Все")
                                .font(.callout)
                                .fontWeight(.regular)
                                .foregroundColor(Color.blue)
                        }
                        
                    }
                }
                LazyVGrid(columns: threeColumnGrid, spacing: 6) {
                    ForEach(taskManager.achievements) { achievement in
                        AchievementComponentView(achievements: achievement)
                    }
                }
            }
            .navigationTitle("Сводка")
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(TaskManagerModel())
    }
}


