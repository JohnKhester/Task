//
//  ActivityBlock.swift
//  Task
//
//  Created by Andrey on 24.06.2023.
//

import SwiftUI

struct ActivityBlock: View {
    var color: Color
    var title: String
    var count: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                RoundedRectangle(cornerRadius: 2)
                    .fill(color)
                    .frame(width: 8, height: 8)
                
                Text(title)
                    .font(Font.system(size: 14))
                    .whiteForegroundWithOpacity()
            }
            
            Text("\(count)")
                .boldFont_24()
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(
            RoundedRectangle(cornerRadius: .cornerRadius, style: .continuous)
                .fill(.white)
                .opacity(0.07)
        )
    }
}


struct ActivityBlock_Previews: PreviewProvider {
    static var previews: some View {
        ActivityBlock(color: Color.red, title: "Demo", count: 0)
    }
}