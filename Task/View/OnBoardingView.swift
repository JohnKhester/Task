//
//  OnBoardingView.swift
//  Task
//
//  Created by Andrey on 07.07.2023.
//

import SwiftUI

struct OnBoardingView: View {
    var onButtonTapped: () -> Void
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            VStack {
                Text("Че ? Как оно ?")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                
                Button(action: {
                    onButtonTapped()
                }) {
                    Text("Да в пизду, нах...")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.greenColor)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(onButtonTapped: {})
    }
}
