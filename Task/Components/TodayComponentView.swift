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
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: "list.clipboard.fill")
                    .mediumFont_18()
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(.orange)
                    .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                
                VStack(alignment: .leading) {
                    Text("Задача")
                        .font(.system(size: 14, weight: .medium))
                        .whiteForegroundWithOpacity()
                    
                    Text("\(taskManager.totalTasksCount)")
                        .boldFont_24()
                        .foregroundColor(Color.white)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.orange)
            }
            .padding(12)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.white).opacity(0.07)
            }
        }.padding(.horizontal, 16)
    }
}

struct TodayComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TodayComponentView()
            .environmentObject(TaskManagerModel())
    }
}
