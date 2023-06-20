//
//  ContentView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var isDetailViewActive = false
    
    var body: some View {
        NavigationView {
            VStack {

            }
            .navigationTitle("Сводка")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
