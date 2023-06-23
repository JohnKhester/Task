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
    
    @State private var rotationAngle: Double = 0
    @State private var scale: CGFloat = 1
    
    var threeColumnGrid = [GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6)]
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea(.all)
                ScrollView {
                    NavigationLink {
                        WidgetDetailView()
                    } label: {
                        VStack(alignment: .leading) {
                            Text(taskManager.currentDateWithDayFormatted())
                                .mediumFont_14()
                                .foregroundColor(Color.white)
                                .opacity(0.5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 8)
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
                                    .foregroundColor(Color.greenColor)
                            }
                        }.padding(.top, 12)
                    }.padding(.horizontal, 16)
                    ZStack {
                        LazyVGrid(columns: threeColumnGrid, spacing: 6) {
                            ForEach(taskManager.achievements) { achievement in
                                AchievementComponentView(achievement: achievement)
                                    .onTapGesture {
                                        selectedAchievement = achievement
                                        isPopupVisible = true
                                    }
                            }
                        }.padding(8)
                    } .background {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(.white).opacity(0.07)
                    }.padding(.horizontal, 16)
                }
                .navigationBarTitle("Сводка")
                //            .toolbarColorScheme(.dark, for: .navigationBar)
                //            .toolbarBackground(Color.background, for: .navigationBar)
                //            .toolbarBackground(.visible, for: .navigationBar)
            }
        }
        .overlay(
            popupView
                .opacity(isPopupVisible ? 1 : 0)
                .animation(Animation.easeInOut(duration: 0.3), value: UUID())
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
                     Spacer()
                    if achievement.isUnlocked {
                        Image(achievement.colorImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .rotationEffect(.degrees(rotationAngle))
                            .scaleEffect(scale)
                            .animation(Animation.linear(duration: 2).repeatForever(autoreverses: true), value: UUID())
                            .onAppear {
                                animateImage()
                            }
                        
                        Text(achievement.title)
                            .boldFont_24()
                            .foregroundColor(.white)
                        Text(achievement.description)
                            .mediumFont_12()
                        Text(achievement.isUnLockedDecription)
                            .mediumFont_12()
                    } else {
                        Image(achievement.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                        Text(achievement.title)
                            .boldFont_24()
                            .foregroundColor(.white)
                        Text(achievement.description)
                            .mediumFont_12()
                        Text(achievement.isLockedDescription)
                            .mediumFont_12()
                            .foregroundColor(.white)
                    }
                        
                    
                    Spacer()
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.05882352941, blue: 0.1254901961, alpha: 1)), Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                )
                .cornerRadius(36)
                .frame(maxWidth: .infinity)
                .frame(height: 346)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
    }
    
    func animateImage() {
        let randomDuration = Double.random(in: 0.5...1.5)
        let randomRotation = Bool.random() ? 360.0 : -360.0
        let randomScale = CGFloat.random(in: 0.8...1.2)

        withAnimation(.easeInOut(duration: randomDuration)) {
            rotationAngle += randomRotation
            scale = randomScale
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + randomDuration) {
            animateImage()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(TaskManagerModel())
    }
}


