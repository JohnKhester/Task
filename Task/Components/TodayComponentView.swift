//
//  TodayComponentView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct TodayComponentView: View {
    @EnvironmentObject private var taskManager: TaskManagerModel
    var body: some View {
        VStack {            
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: "figure.walk")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(.teal)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                
                VStack(alignment: .leading) {
                    Text("Задача")
                        .font(.body)
                    
                    Text("Все: \(taskManager.totalTasksCount)")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.blue)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.ultraThinMaterial).opacity(0.5)
            }
        }
        
    }
}

struct TodayComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TodayComponentView()
            .environmentObject(TaskManagerModel())
    }
}