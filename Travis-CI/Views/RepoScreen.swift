//
//  RepoScreen.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 15/02/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State private var isShowing = false
    @State private var showingSafariVC = false
    
    var body: some View {
            NavigationView {
                if networkManager.loadingState == .loaded {
                    List {
                        Section(header: Text("Favs").font(.largeTitle)) {
                            ForEach(networkManager.repos) { repo in
                                if repo.starred {
                                    NavigationLink(destination: RepoBuildDetailView(repo: repo)
                                            .navigationBarTitle(Text(repo.name))) {
                                    RepoBuildView(repo: repo)
                                       .contextMenu {
                                           Button(action: {
                                                self.showingSafariVC.toggle()
                                           }) {
                                            Text("Repo URL")
                                            Image(systemName: "globe")
                                           }.sheet(isPresented: self.$showingSafariVC) {
                                            SafariView(url: "https://github.com/\(repo.slug)")
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
                        Section(header: Text("Other").font(.largeTitle)) {
                            ForEach(networkManager.repos) { repo in
                                if !repo.starred && repo.defaultBranch.lastBuild != nil {
                                    NavigationLink(destination: RepoBuildDetailView(repo: repo)
                                            .navigationBarTitle(Text(repo.name))) {
                                    RepoBuildView(repo: repo)
                                       .contextMenu {
                                           Button(action: {
                                                self.showingSafariVC.toggle()
                                           }) {
                                            Text("Repo URL")
                                            Image(systemName: "globe")
                                           }.sheet(isPresented: self.$showingSafariVC) {
                                            SafariView(url: "https://github.com/\(repo.slug)")
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
                    }
                    .navigationBarTitle("Repositories")
                } else if networkManager.loadingState == .loading {
                    LoadingView()
                    .navigationBarTitle("Repositories")
                } else {
                    Text("Error Connecting to API")
                    .navigationBarTitle("Repositories")
                }
            
            }
    }
}
