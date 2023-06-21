//
//  CircularCharView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct CircularCharView: View {
    var progress: CGFloat // Пример значений для диаграммы
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.gray)                   

                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(-90))

                Text(String(format: "%.0f%%", progress * 100))
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
    }
 
}

struct CircularCharView_Previews: PreviewProvider {
    static var previews: some View {
        CircularCharView(progress: 0.7)
    }
}
