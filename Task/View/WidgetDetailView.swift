//
//  WidgetDetailView.swift
//  Task
//
//  Created by Andrey on 20.06.2023.
//

import SwiftUI

struct WidgetDetailView: View {
    var body: some View {
        VStack {
            Text("Страница подробнее на виджет")
            ChangeTargetButtonView()
        }
    }
}

struct WidgetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetDetailView()
    }
}
