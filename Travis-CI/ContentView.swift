//
//  ContentView.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 26/01/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import SwiftUI
import Combine

struct Build: Identifiable, Codable {
    var id: Int
    var number: String
    var state: String
//    var duration: Int
//    var startedAt: String
//    var finishedAt: String
}

struct Branch: Codable {
//    var id: Int
    var name: String
    var lastBuild: Build?
//    var updatedAt: String
    
}

struct Repository: Identifiable, Codable {
    var id: Int
    var name: String
    var slug: String
    var description: String?
    var starred: Bool
    var defaultBranch: Branch?
    var active: Bool
//    var buildNo: Int
//    var duration: Int
//    var Finished: Int
}




class NetworkManager: ObservableObject {
    @Published var repos:[Repository] = [Repository]()

    func getRepos() {
        let url = URL(string: "https://api.travis-ci.com/repos?include=branch.last_build")!
        let token = "token"
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

            let repos = try! decoder.decode([Repository].self, from: data, keyPath: "repositories")
//            dump(repos)
            DispatchQueue.main.async {
                self.repos = repos
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


struct HomeView: View {
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
            NavigationView {
                List {
                    Section(header: Text("Favs")) {
                        ForEach(networkManager.repos) { repo in
                            if repo.starred {
                                NavigationLink(destination: RepoBuildDetailView(repo: repo)
                                        .navigationBarTitle(Text(repo.name))) {
                                RepoBuildView(repo: repo)
                                   .contextMenu {
                                       Button(action: {
                                           // change country setting
                                       }) {
                                        Text("Repo URL")
                                        Image(systemName: "globe")
                                       }

                                       Button(action: {
                                           // enable geolocation
                                       }) {
                                           Text("Detect Location")
                                           Image(systemName: "location.circle")
                                       }
                                   }
                                }
                            }
                        }
                    }
                    Section(header: Text("Other")) {
                        ForEach(networkManager.repos) { repo in
                            if !repo.starred {
                                NavigationLink(destination: RepoBuildDetailView(repo: repo)
                                        .navigationBarTitle(Text(repo.name))) {
                                RepoBuildView(repo: repo)
                                   .contextMenu {
                                       Button(action: {
                                           // change country setting
                                       }) {
                                        Text("Repo URL")
                                        Image(systemName: "globe")
                                       }

                                       Button(action: {
                                           // enable geolocation
                                       }) {
                                           Text("Detect Location")
                                           Image(systemName: "location.circle")
                                       }
                                   }
                                }
                            }
                        }
                    }
                }.listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Repositories"))
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
