//
//  SplashScreenView.swift
//  Devis
//
//  Created by Youssef Ahab on 01/07/2022.
//

import SwiftUI
import CoreMedia

struct SplashScreenView: View {
    @State private var size = 1.5
    @State private var opacity = 1.0
     
    var body: some View {
        ZStack(alignment: .center) {
            Image("thales")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 0, maxWidth: .infinity)
                .scaleEffect(size)
            VStack {
                Spacer()
                Text(Constants.appName)
                    .foregroundColor(.black)
                    .font(.custom(Constants.typeFont, size: 33.0)).bold()
                    .padding()
            }
            .ignoresSafeArea()
         }
        .background(Color.black)
        .opacity(opacity)
        .scaledToFill()
        .transition(AnyTransition.opacity.animation(.easeInOut))
        .transition(AnyTransition.scale.animation(.easeInOut))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                withAnimation(.easeIn) { size = 5.0 ; opacity = 0 }
            }
            
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
