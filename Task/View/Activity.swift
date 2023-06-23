//
//  Activity.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//

import SwiftUI

 
struct Activity: View {
    init() {
        UITabBar.appearance().barTintColor = UIColor.black
    }
    var body: some View {
        NavigationView {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Главная", systemImage: "target")
                    }.tag(0)
                StatisticView()
                    .tabItem {
                        Label("Статистика", systemImage: "chart.bar.xaxis")
                    }.tag(1)
                Settings()
                    .tabItem {
                        Label("Настройки", systemImage: "gearshape")
                    }.tag(2)
            }
            .tint(Color.teal)
            
        }
        .environmentObject(TaskManagerModel())
    }
}

struct Activity_Previews: PreviewProvider {
    static var previews: some View {
        Activity()
    }
}
