//
//  Settings.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        List {
            Text("Изменить цель задач")
            Text("Уведомления")
            Text("Конфидициальность")
            Text("Отключить рекламу")
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
