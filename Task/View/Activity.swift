//
//  Activity.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//

import SwiftUI

struct Activity: View {
    var body: some View {
        NavigationView {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Главная", systemImage: "target")
                    }.tag(0)
                Settings()
                    .tabItem {
                        Label("Настройки", systemImage: "gearshape")
                    }.tag(1)
            }
        }
        .environmentObject(TaskManagerModel())
    }
}

struct Activity_Previews: PreviewProvider {
    static var previews: some View {
        Activity()
    }
}
