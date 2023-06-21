//
//  WidgetDataModel.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import Foundation
import Combine

class WidgetDataModel: ObservableObject {
    @Published var title: String = "Задачи"
    @Published var taget: String = "Цель"
    @Published var taskTodayValue: Int = 0
    @Published var oldTaskValue: Int = 5
}
