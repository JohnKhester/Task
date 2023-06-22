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
    @State private var isPopupVisible = false
    @State private var selectedAchievement: Achievement?
    
    
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
                            AchievementComponentView(achievement: achievement)
                                .onTapGesture {
                                    selectedAchievement = achievement
                                    isPopupVisible = true
                                }
                        }
                    }
                
            }
            .navigationTitle("Сводка")
        }
        .overlay(
            popupView
                .opacity(isPopupVisible ? 1 : 0)
                .animation(Animation.easeInOut(duration: 1.0), value: UUID())
                .zIndex(1)
        )
    }
    @ViewBuilder
    private var popupView: some View {
        if let achievement = selectedAchievement {
            GeometryReader { geometry in
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isPopupVisible = false
                        }
                    }
                
                VStack {
                    HStack {
                        Text(achievement.title)
                            .font(.title)
                            .bold()
                        Spacer()
                        Button(action: {
                            withAnimation {
                                isPopupVisible = false
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    // Additional content for the popup view
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(TaskManagerModel())
    }
}


