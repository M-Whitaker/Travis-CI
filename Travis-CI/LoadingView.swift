//
//  LoadingView.swift
//  Travis-CI
//
//  Created by Adrian Whitaker on 16/02/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    @State private var aquaBounce = false
    @State private var blueberryBounce = false
    @State private var grapeBounce = false
    @State private var magentaBounce = false
    @State private var strawberryBounce = false
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
                    .offset(y: aquaBounce ? 0 : -150)
                    .animation(Animation.interpolatingSpring(stiffness: 70, damping: 5).repeatForever(autoreverses: false))
                    .onAppear() {
                        self.aquaBounce.toggle()
                }
                
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)))
                    .offset(y: blueberryBounce ? 0 : -150)
                    .animation(Animation.interpolatingSpring(stiffness: 70, damping: 5).repeatForever(autoreverses: false).delay(0.03))
                    .onAppear() {
                        self.blueberryBounce.toggle()
                }
                
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)))
                    .offset(y: grapeBounce ? 0 : -150)
                    .animation(Animation.interpolatingSpring(stiffness: 70, damping: 5).repeatForever(autoreverses: false).delay(0.03*2))
                    .onAppear() {
                        self.grapeBounce.toggle()
                }
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1)))
                    .offset(y: magentaBounce ? 0 : -150)
                    .animation(Animation.interpolatingSpring(stiffness: 70, damping: 5).repeatForever(autoreverses: false).delay(0.03*3))
                    .onAppear() {
                        self.magentaBounce.toggle()
                }
                
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)))
                    .offset(y: strawberryBounce ? 0 : -150)
                    .animation(Animation.interpolatingSpring(stiffness: 70, damping: 5).repeatForever(autoreverses: false).delay(0.03*4))
                    .onAppear() {
                        self.strawberryBounce.toggle()
                }
                
               
            }
        }.frame(height: UIScreen.main.bounds.height - 200)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

