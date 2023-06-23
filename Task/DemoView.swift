//
//  DemoView.swift
//  Task
//
//  Created by Andrey on 23.06.2023.
//

import SwiftUI

import SwiftUI

struct DemoView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Привет, это демо страница!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                
                ForEach(0..<20) { index in
                    Text("Строка \(index + 1)")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                }
            }
        }
        .background(Color.red)
        .navigationBarTitle("Демо", displayMode: .inline)
        .navigationBarColor(backgroundColor: .red, tintColor: .white) // Кастомный модификатор навигационной панели
    }
}

extension View {
    func navigationBarColor(backgroundColor: UIColor, tintColor: UIColor) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, tintColor: tintColor))
    }
}

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor
    var tintColor: UIColor
    
    init(backgroundColor: UIColor, tintColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: tintColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
        .onAppear {
            UINavigationBar.appearance().backgroundColor = backgroundColor
            UINavigationBar.appearance().tintColor = tintColor
        }
        .onDisappear {
            UINavigationBar.appearance().backgroundColor = nil
            UINavigationBar.appearance().tintColor = nil
        }
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
    }
}

 
