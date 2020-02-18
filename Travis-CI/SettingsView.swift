//
//  SettingsView.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 17/02/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var SettingsVM = Settings()
    @State var tokenHidden:Bool = true
    
    var body: some View {
        NavigationView{
            VStack {
                Circle()
                    .frame(width: 200, height: 200)
                Form {
                    Toggle(isOn: $SettingsVM.authEnabled) {
                        Text("Biometrics Auth")
                    }
                    Section {
                        if tokenHidden {
                            SecureField("Token", text: $SettingsVM.token)
                        } else {
                            TextField("Token", text: $SettingsVM.token)
                        }
                        Button(tokenHidden ? "View Token" : "Hide Token") {
                            self.tokenHidden.toggle()
                        }
                    }
                }
            }
            
        .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}