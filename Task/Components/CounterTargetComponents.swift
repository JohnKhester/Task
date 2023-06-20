//
//  CounterTargetComponents.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct CounterTargetComponents: View {
    @ObservedObject var counter = CounterTargetModel()
    var body: some View {
        VStack {
            Text("Цель: \(counter.valueTarget)")
        }
    }
}

struct CounterTargetComponents_Previews: PreviewProvider {
    static var previews: some View {
        CounterTargetComponents()
    }
}
