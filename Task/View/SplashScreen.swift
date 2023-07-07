//
//  SplashScreen.swift
//  Task
//
//  Created by Andrey on 07.07.2023.
//

import SwiftUI


struct SplashScreen: View {
  //  @State var isActive = true
    var body: some View {
        ZStack {
            Color.background
                .edgesIgnoringSafeArea(.all)
            
            Text("Саня Привет!=))")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
//        .onAppear {
//                   DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                       isActive = true
//                   }
//               }
//               .fullScreenCover(isPresented: $isActive, content: Activity.init)
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
