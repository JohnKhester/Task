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
    @State private var isAnimating = false
    
    var threeColumnGrid = [GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6)]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea(.all)
                
                ScrollView {
                    NavigationLink(destination: WidgetDetailView()) {
                        VStack(alignment: .leading) {
                            Text(taskManager.currentDateWithDayFormatted())
                                .mediumFont_14()
                                .foregroundColor(Color.white)
                                .opacity(0.5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 8)
                            WidgetComponentView()
                        }
                        .padding(.horizontal, 16)
                    }
                    
                    VStack {
                        HStack {
                            Text("Today")
                                .boldFont_18()
                                .foregroundColor(Color.white)
                                .padding(.top, 8)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    NavigationLink(destination: TaskView()) {
                        TodayComponentView()
                    }
                    
                    VStack(spacing: 6.0) {
                        HStack {
                            Text("Rewards")
                                .boldFont_18()
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            NavigationLink(destination: AchievementView()) {
                                HStack {
                                    Text("See All")
                                        .font(.callout)
                                        .fontWeight(.regular)
                                        .foregroundColor(Color.greenColor)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.greenColor)
                                        .opacity(0.5)
                                }
                            }
                        }
                        .padding(.top, 12)
                    }
                    .padding(.horizontal, 16)
                    
                    ZStack {
                        LazyVGrid(columns: threeColumnGrid, spacing: 6) {
                            ForEach(taskManager.achievements) { achievement in
                                AchievementComponentView(achievement: achievement)
                                    .onTapGesture {
                                        selectedAchievement = achievement
                                        isPopupVisible = true
                                    }
                            }
                        }
                        .padding(8)
                    }
                    .background {
                        RoundedRectangle(cornerRadius: .cornerRadius, style: .continuous)
                            .fill(Color.darkColor)
                    }
                    .padding(.horizontal, 16)
                }
                .navigationBarTitle("Goal Tracker")
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
                            Image(systemName: "xmark")
                                .whiteForegroundWithOpacity()
                        }
                    }
                    .padding([.trailing, .top], 24)
                    
                    Spacer()
                    
                    Image(achievement.isUnlocked ? achievement.colorImage : achievement.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .offset(y: isAnimating ? -5 : 5)
                        .rotationEffect(isAnimating ? Angle(degrees: 5) : Angle(degrees: -5))
                        .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                        .onAppear {
                            isAnimating = true
                        }
                        .padding(.vertical, 6)
                    
                    VStack {
                        Text(achievement.title)
                            .boldFont_24()
                            .foregroundColor(Color.greenColor)
                            .padding(.vertical, 4)
                        
                        Text(achievement.description)
                            .mediumFont_14()
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                        
                        Text(achievement.isUnlocked ? achievement.isUnLockedDecription : achievement.isLockedDescription)
                            .mediumFont_13()
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 40)
                    }
                    .padding([.leading, .trailing], 24)
                    
                    Spacer()
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.05882352941, blue: 0.1254901961, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .cornerRadius(36)
                .frame(maxWidth: .infinity)
                .frame(height: 356)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
    }
    
    func startAchievementAnimation() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                isAnimating.toggle()
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


