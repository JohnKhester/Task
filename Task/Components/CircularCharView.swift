//
//  CircularCharView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct CircularCharView: View {
    var progress: CGFloat
    var startColor: Color
    var endColor: Color
    
    var body: some View {
        let gradient = AngularGradient(gradient: Gradient(colors: [startColor, endColor]), center: .center, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360 * progress))
        ZStack {
            Circle()
                .stroke(lineWidth: 16)
                .opacity(0.3)
                .foregroundColor(.gray) 
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 16, lineCap: .round, lineJoin: .round))
                .fill(gradient) // Apply gradient-like effect
                .rotationEffect(.degrees(-90))
        }
    }
}


struct CircularCharView_Previews: PreviewProvider {
    static var previews: some View {
        CircularCharView(progress: 0.7, startColor: .blue, endColor: .teal)
            .frame(width: 200, height: 200)
    }
}
