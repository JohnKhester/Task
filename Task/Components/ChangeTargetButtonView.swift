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
                        Text("Change Goal")
                            .font(.headline)
                            .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding(14)
                .background {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.greenColor)
                }
            })
            .sheet(isPresented: $isChangeTargetActive) {
                ZStack {
                    Color.background.ignoresSafeArea(.all)
                VStack {
                    HStack {
                        Button(action: {
                            self.isChangeTargetActive.toggle()
                        }) {
                            Text("Cancel")
                                .foregroundColor(Color.greenColor)
                        }.padding([.leading, .top], 24)
                        Spacer()
                    }
                    Spacer()
                    VStack {
                        Text("Goal Tracker")
                            .boldFont_32()
                            .foregroundColor(.white)
                            .padding(.vertical, 16)
                        Text("Stay motivated and laser-focused on your objectives.Get ready to unlock your full potential and unleash your productivity with Goal Tracker.")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .mediumFont_14()
                            .padding(.horizontal, 30)
                        
                    }.padding(.vertical, 16)
                    CounterTargetComponents(isChangeTargetActive: $isChangeTargetActive)
                    Spacer()
                }
            }
            }
        }
    }
}

struct ChangeTargetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeTargetButtonView()
            .environmentObject(TaskManagerModel())
    }
}
