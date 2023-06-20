//
//  TodayView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct TodayView: View {
    var body: some View {
        VStack {
            Text("Детали")
                .font(.title)
                .padding()
            
            Button(action: {
                // Действие при нажатии кнопки "Назад"
            }) {
                Image(systemName: "chevron.left")
                Text("Назад")
            }
            .padding()
        }
        .navigationTitle("Детали")
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
