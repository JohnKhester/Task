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
            HStack(alignment: .center, spacing: 14) {
                Image(systemName: "list.clipboard.fill")
                    .mediumFont_18()
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(red: Double(0xDB)/255.0, green: Double(0x17)/255.0, blue: Double(0x26)/255.0), Color(red: Double(0xBD)/255.0, green: Double(0x17)/255.0, blue: Double(0x81)/255.0)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                
                VStack(alignment: .leading) {
                    Text("My All Tasks")
                        .font(.system(size: 14, weight: .medium))
                        .whiteForegroundWithOpacity()
                    
                    Text("\(taskManager.totalTasksCount)")
                        .boldFont_24()
                        .foregroundColor(Color.white)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.white)
                    .opacity(0.5)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: .cornerRadius, style: .continuous)
                    .fill(Color.darkColor)
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
