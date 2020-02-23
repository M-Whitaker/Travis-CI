//
//  LoadingView.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 16/02/2020.
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
            VStack {
                Image("travis-ci-logo")
                    .resizable()
                    .frame(width: 400, height: 300)
                HStack {
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .offset(y: aquaBounce ? 0 : -75)
                        .animation(Animation.interpolatingSpring(stiffness: 140, damping: 5).repeatForever(autoreverses: false))
                        .onAppear() {
                            self.aquaBounce.toggle()
                    }
                    
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        .offset(y: blueberryBounce ? 0 : -75)
                        .animation(Animation.interpolatingSpring(stiffness: 140, damping: 5).repeatForever(autoreverses: false).delay(0.03))
                        .onAppear() {
                            self.blueberryBounce.toggle()
                    }
                    
                    Circle()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        .offset(y: grapeBounce ? 0 : -75)
                        .animation(Animation.interpolatingSpring(stiffness: 140, damping: 5).repeatForever(autoreverses: false).delay(0.03*2))
                        .onAppear() {
                            self.grapeBounce.toggle()
                    }
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

