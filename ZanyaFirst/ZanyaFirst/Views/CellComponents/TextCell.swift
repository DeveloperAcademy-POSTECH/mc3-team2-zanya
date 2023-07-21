//
//  TextView.swift
//  ZanyaFirst
//
//  Created by Kimjaekyeong on 2023/07/19.
//

import SwiftUI

struct TextCell: View {
    
    var text: String
    var size: CGFloat
    var color: Color
    
    var body: some View {
        VStack{
            Text(text)
                .font(Font.custom("LINESeedKR-Rg", size: size))
                .foregroundColor(color)
        }
    }
}
struct TextCell_Previews: PreviewProvider {
    static var previews: some View {
        TextCell(text: "일어나라냥", size: 20, color: .cyan)
    }
}
