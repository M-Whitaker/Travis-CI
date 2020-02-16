//
//  ContentView.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 26/01/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import SwiftUI
import Combine

class NetworkManager: ObservableObject {
    @Published var repos:[Repository] = [Repository]()

    func getRepos() {
        let url = URL(string: "https://api.travis-ci.com/repos?include=branch.last_build")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("3", forHTTPHeaderField: "Travis-API-Version")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!); return }
            guard let data = data else { print("No data"); return }
        //    print(response)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            let result = try! decoder.decode(Result.self, from: data)
//            dump(repos)
            DispatchQueue.main.async {
                self.repos = result.repositories
            }
            print("Finished")
            
        }.resume()
    }
    init() {
        getRepos()
    }
}
        

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "tray.full.fill")
                    Text("Repos")
                }.tag(0)
            Text("Second View")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }.tag(1)
            Text("Profile View")
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }.tag(2)
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
