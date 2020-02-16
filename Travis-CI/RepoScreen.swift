//
//  RepoScreen.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 15/02/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import SwiftUI
import SwiftUIRefresh

struct HomeView: View {
    @ObservedObject var networkManager = NetworkManager()
    @State private var isShowing = false
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
                                        // summon the Safari sheet
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
                    .pullToRefresh(isShowing: $isShowing) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.isShowing = false
                        }
                    }
            .navigationBarTitle(Text("Repositories"))
            }
    }
}
