//
//  ContentView.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 26/01/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import LocalAuthentication
import SwiftUI
import Combine

class NetworkManager: ObservableObject {
    
    @ObservedObject var SettingsVM = Settings()
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Published var repos:[Repository] = [Repository]()
    @Published var user:[User] = [User]()
    @Published var loadingState = LoadingState.loading

    func getRepos() {
        let url = URL(string: baseURL + "/repos?include=branch.last_build")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("token \(SettingsVM.token)", forHTTPHeaderField: "Authorization")
        request.setValue("3", forHTTPHeaderField: "Travis-API-Version")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error as Any)
                return
                
            }
            guard let data = data else {
                print("No data")
                return
                
            }
            
            let httpResponse = response as? HTTPURLResponse
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let result = try? decoder.decode(Result.self, from: data)
//            dump(repos)
            DispatchQueue.main.async {
                if httpResponse?.statusCode == 200 {
                    self.repos = result!.repositories
                    self.loadingState = .loaded
                } else {
                    self.loadingState = .failed
                }
            }
            
        }.resume()
    }
    func getUser() {
        let url = URL(string: "https://api.travis-ci.com/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("token \(SettingsVM.token)", forHTTPHeaderField: "Authorization")
        request.setValue("3", forHTTPHeaderField: "Travis-API-Version")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error as Any)
                return
                
            }
            guard let data = data else {
                print("No data")
                return
                
            }
            
            let httpResponse = response as? HTTPURLResponse
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let user = try? decoder.decode(User.self, from: data)
//            dump(user)
            DispatchQueue.main.async {
                if httpResponse?.statusCode == 200 {
                    self.user = [user!]
                }
            }
            
        }.resume()
    }
    
    init() {
        getRepos()
        getUser()
    }
}
        

struct ContentView: View {
    
    @ObservedObject var settingsVM = Settings()
    @State private var isUnlocked = false
    
    var body: some View {
            TabView {
                if settingsVM.signInSuccess == false {
                    AuthView(signInSuccess: $settingsVM.signInSuccess)
                }
                else if isUnlocked || settingsVM.authEnabled == false {
                    HomeView()
                        .tabItem {
                            Image(systemName: "tray.full.fill")
                            Text("Repos")
                        }.tag(0)
                    SearchView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }.tag(1)
                    SettingsView(signInSuccess: $settingsVM.signInSuccess)
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profile")
                        }.tag(2)
                } else {
                    Button("Authenticate") {
                        self.authenticate()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
            }
            .onAppear {
                if self.settingsVM.authEnabled {
                    self.authenticate()
                }
            }
        }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your repos."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            }
        } else {
            // no biometrics - redirect to pin code
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
            .environment(\.colorScheme, .dark)
        }
    }
}
