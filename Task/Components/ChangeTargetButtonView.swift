//
//  ChangeTargetButtonView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct ChangeTargetButtonView: View {
    @State private var isChangeTargetActive = false
    var body: some View {
        VStack {
            Button(action: {
                self.isChangeTargetActive.toggle()
            }, label: {
                ZStack {
                        Text("Изменить цель")
                            .font(.headline)
                            .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 62)
                .padding(.horizontal, 16)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(16)
                 
            })
            .sheet(isPresented: $isChangeTargetActive) {
                Text("Hello")
            }
        }
    }
}

struct ChangeTargetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeTargetButtonView()
    }
}
