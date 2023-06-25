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
    @State private var isAnimating = false
    var threeColumnGrid = [GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6), GridItem(.flexible(), spacing: 6)]
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    HStack {
                        Text("Victory Hall")
                            .boldFont_32()
                            .foregroundColor(.white)
                        Spacer()
                    }.padding(.leading, 16)
                        .foregroundColor(.white.opacity(0.5))
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
                        .zIndex(2)
                        .offset(y: isAnimating ? -5 : 5)
                        .rotationEffect(isAnimating ? Angle(degrees: 5) : Angle(degrees: -5))
                        .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                        .onAppear {
                            isAnimating = true
                        }
                        .padding(.vertical, 6)
                    
                    VStack {
                        Text(achievement.title)
                            .boldFont_32()
                            .foregroundColor(Color.white)
                            .padding(.vertical, 4)
                        
                        Text(achievement.description)
                            .boldFont_18()
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
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7411764706, green: 0.09019607843, blue: 0.5058823529, alpha: 1)), Color(#colorLiteral(red: 0.8588235294, green: 0.09019607843, blue: 0.1490196078, alpha: 1))]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        
                        ForEach(0..<Int.random(in: 1...22), id: \.self) { index in
                            Circle()
                                .foregroundColor(.white)
                                .opacity(Double.random(in: 0.1...0.5))
                                .frame(width: CGFloat.random(in: 2...6), height: CGFloat.random(in: 4...12))
                                .offset(x: CGFloat.random(in: -250...250), y: CGFloat.random(in: -200...200))
                                .animation(Animation.easeInOut(duration: Double.random(in: 3...8)).repeatForever(autoreverses: true).delay(Double(index) * 0.8), value: UUID())
                        }
                    }
                )


                .cornerRadius(36)
                .padding([.leading, .trailing], 16)
                .frame(maxWidth: .infinity)
                .frame(height: 356)
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




 

