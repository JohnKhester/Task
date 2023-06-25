//
//  Settings.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//

import SwiftUI

struct Settings: View {
    @State private var isChangeTargetActive = false
    var body: some View {
        NavigationStack {
            List {
                Button(action: {
                    self.isChangeTargetActive = true
                }, label: {
                    Text("Change Task Goal")
                })
                
                Text("Notifications")
                Text("Privacy")
                Text("ADS ")
            }.sheet(isPresented: $isChangeTargetActive) {
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
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

 
struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
            .environmentObject(TaskManagerModel())
    }
}
