//
//  AuthView.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 22/02/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import Combine
import SwiftUI
import SimpleOAuth2

struct AuthView: View {
    
    @ObservedObject var SettingsVM = Settings()
    @Binding var signInSuccess: Bool
    @State var authManager = OAuth2Manager()
    @State var cancellable: AnyCancellable?
    @State var credentials: OAuth2Credentials?
    @Environment(\.colorScheme) var colorScheme
    
    let request: OAuth2Request = .init(authUrl: "https://github.com/login/oauth/authorize",
                                       tokenUrl: "https://github.com/login/oauth/access_token",
                                       clientId: infoForKey("GitHub API ClientID")!,
                                       redirectUri: infoForKey("GitHub API Redirect URL")!,
                                       clientSecret: infoForKey("GitHub API Secret")!,
                                       scopes: ["user,repo"])
    
    func travisCIOAuthSignIn(access_token: String) {
        let url = URL(string: "https://api.travis-ci.com/auth/github?github_token=\(access_token)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            do {
                let jsondata = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                DispatchQueue.main.async {
                    self.SettingsVM.token = jsondata!["access_token"] as! String
                    self.signInSuccess = true
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()

    }
    
    func signIn() {
        if (SettingsVM.gh_token?.accessToken == nil) {
            /* TODO: Check that api key is correct before signin */
            print("Using manual Token")
            self.signInSuccess = true
        } else {
            travisCIOAuthSignIn(access_token: SettingsVM.gh_token!.accessToken)
        }
        
    }
    
    var body: some View {
            VStack {
                Image("travis-ci-logo")
                    .resizable()
                    .frame(width: 400, height: 300)
                Button(action: {
                    cancellable = authManager.signIn(with: request)
                        .sink( receiveCompletion: { result in
                           switch result {
                               case .failure(let error):
                                   print(error.localizedDescription)
                               default: break
                           }
                        }, receiveValue: { credentials in
                            self.credentials = credentials
                            print(credentials)
                            credentials.save()
                            travisCIOAuthSignIn(access_token: credentials.accessToken)
                        })
                }) {
                    HStack {
                        Text("Sign in with")
                        Image(colorScheme == .light ? "GitHub_Logo" : "GitHub_Logo_White")
                            .resizable()
                            .frame(width: 250, height: 102.5)
                    }
                }
                Text("https://travis-ci.com/account/preferences")
                TextField("Token", text: $SettingsVM.token)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("Login") { signIn() }
            }
    }
}
