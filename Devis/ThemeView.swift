//
//  ThemeView.swift
//  Devis
//
//  Created by Youssef Ahab on 17/06/2022.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme
    @Binding var isGradient: Bool
    @Binding var whiteFont: Bool
    
    var body: some View {
        ZStack {
            if (isGradient){
                RoundedRectangle(cornerRadius: CGFloat(Constants.roundedRectRadius))
                        .fill(LinearGradient(gradient: Gradient(colors: [theme.mainColor,Color.black]), startPoint: .leading, endPoint: .trailing))
            }
            else{
                RoundedRectangle(cornerRadius: CGFloat(Constants.roundedRectRadius))
                    .fill(theme.mainColor)
            }
            Label(theme.name, systemImage: "paintpalette")
                .padding(4)
        }
        .foregroundColor(whiteFont ? .white : .black)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .teal, isGradient: .constant(true), whiteFont: .constant(true))
    }
}

