//
//  CounterTargetModel.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import Foundation
import Combine

class CounterTargetModel: ObservableObject {
    @Published var valueTarget: Int = 5
    
    func increment() {
        valueTarget += 1
    }
    
    func dicrement() {
        valueTarget -= 1
    }
}
