//
//  ContentView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI



struct HomeView: View {
    @EnvironmentObject private var taskManager: TaskManagerModel
    @State private var isPopupVisible = false
    @State private var selectedAchievement: Achievement?
    @State private var isHeaderTransparent = true
    var threeColumnGrid = [GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6)]
    var body: some View {
        NavigationStack {
            ScrollView {
                NavigationLink {
                    WidgetDetailView()
                } label: {
                    VStack(alignment: .leading) {
                        Text(taskManager.currentDateWithDayFormatted())
                            .font(Font.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(Color.white)
                            .opacity(0.5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 12)
                        WidgetComponentView()
                    }.padding(.horizontal, 16)
                }
                VStack {
                    HStack {
                        Text("Сегодня")
                            .boldFont_18()
                            .foregroundColor(Color.white)
                            .padding(.top, 8)
                        Spacer()
                    }
                }.padding(.horizontal, 16)
                
                NavigationLink {
                    TaskView()
                } label: {
                    TodayComponentView()
                }
                VStack(spacing: 6.0) {
                    HStack {
                        Text("Награды")
                            .boldFont_18()
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        NavigationLink {
                            AchievementView()
                        } label: {
                            Text("Все")
                                .font(.callout)
                                .fontWeight(.regular)
                                .foregroundColor(Color.white)
                        }
                    }.padding(.top, 12)
                }.padding(.horizontal, 16)
                
                LazyVGrid(columns: threeColumnGrid, spacing: 6) {
                    ForEach(taskManager.achievements) { achievement in
                        AchievementComponentView(achievement: achievement)
                            .onTapGesture {
                                selectedAchievement = achievement
                                isPopupVisible = true
                            }
                    }
                }.padding(.horizontal, 16)
            }
            .navigationBarTitle("Сводка")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .background(Color.background)
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
                Color.black.opacity(0.7)
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
                }
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


