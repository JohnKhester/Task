//
//  TodayComponentView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct TodayComponentView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Сегодня")
                    .font(.headline)
                    .foregroundColor(.black)
                Text("23")
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.black)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 22)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(16)
        .frame(maxWidth: .infinity)
        .frame(height: 82)
    }
}

struct TodayComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TodayComponentView()
    }
}
