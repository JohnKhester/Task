//
//  AchievementView.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//

import SwiftUI

struct AchievementView: View {
    @State private var isPopupVisible = false
    @State private var selectedAchievement: Achievement?
    @EnvironmentObject private var taskManager: TaskManagerModel
    var threeColumnGrid = [GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6)]
    
    var body: some View {
        ScrollView {
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

struct AchievementView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementView()
            .environmentObject(TaskManagerModel())
    }
}




 

