//
//  TodayView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct TodayView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

       var btnBack : some View { Button(action: {
           self.presentationMode.wrappedValue.dismiss()
           }) {
               HStack {
               Image("ic_back") // set image here
                   .aspectRatio(contentMode: .fit)
                   .foregroundColor(.white)
                   Text("Go back")
               }
           }
       }
       
       var body: some View {
               List {
                   Text("sample code")
           }
           .navigationBarBackButtonHidden(true)
           .navigationBarItems(leading: btnBack)
       }
}


struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
