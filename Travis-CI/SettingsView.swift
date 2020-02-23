//
//  SettingsView.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 17/02/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import SwiftUI
import Combine

struct SettingsView: View {
    @ObservedObject var SettingsVM = Settings()
    @ObservedObject var networkManager = NetworkManager()
    @State var tokenHidden:Bool = true
    @Binding var signInSuccess: Bool
    
    var body: some View {
        NavigationView{
            VStack {
                RemoteImage(imageUrl: networkManager.user.first?.avatarUrl ?? "")
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
                    Section {
                        Button("Logout") { self.signInSuccess = false }
                            .foregroundColor(.red)
                    }
                }
            }
            
            .navigationBarTitle(networkManager.user.first?.name ?? "Settings")
        }
    }
}

struct RemoteImage: View {
    @ObservedObject var remoteImageURL: RemoteImageURL

    init(imageUrl: String) {
        remoteImageURL = RemoteImageURL(imageURL: imageUrl)
    }

    var body: some View {
        Image(uiImage: UIImage(data: remoteImageURL.data) ?? UIImage())
            .resizable()
            .clipShape(Circle())
            .frame(width: 150.0, height: 150.0)
    }
}

class RemoteImageURL: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    @Published var data = Data()
    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            DispatchQueue.main.async { self.data = data }

            }.resume()
    }
}
