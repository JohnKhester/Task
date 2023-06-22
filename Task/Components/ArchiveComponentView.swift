//
//  ArchiveComponentView.swift
//  Task
//
//  Created by Andrey on 21.06.2023.
//

import SwiftUI

struct ArchiveComponentView: View {
   // @ObservedObject var widgetModel = WidgetDataModel()
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: "figure.run")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                
                VStack(alignment: .leading) {
                    Text("Архив")
                        .font(.body)
                    
                    Text("jjojo")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.blue)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.black)
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(.ultraThinMaterial).opacity(0.5)
            }
        }
        
    }
}

struct ArchiveComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveComponentView()
    }
}
