//
//  RepoBuildDetailView.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 31/01/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import SwiftUI

struct RepoBuildDetailView: View {
    let repo: Repository
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white)
                    .shadow(radius: 10)
                VStack(alignment: .leading, spacing: 15) {
                    Text(repo.defaultBranch.lastBuild?.commit.message.split(separator: "\n")[0] ?? "")
                        .padding(.top, 5)
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "stopwatch")
                        Text("Ran for " + printSecondsToHoursMinutesSeconds(seconds: repo.defaultBranch.lastBuild?.duration ?? 0))
                    }
                    HStack {
                        Button(action: {

                            let url: NSURL = URL(string: "https://github.com/" + self.repo.slug + "/commit/" + (self.repo.defaultBranch.lastBuild?.commit.sha ?? ""))! as NSURL

                            UIApplication.shared.open(url as URL)

                        }) {
                            HStack {
                                Image(systemName: "shuffle")
                                Text(verbatim: String("Commit " + (repo.defaultBranch.lastBuild?.commit.sha.prefix(7) ?? "") ))
                            }
                            
                        }
                        Spacer()
                        Image(systemName: "calendar")
                        Text(convertTime(isoDate: repo.defaultBranch.lastBuild!.finishedAt).timeAgoDisplay())
                        //Text(convertTime(isoDate: repo.defaultBranch.lastBuild?.finishedAt ?? "").description)
                    }
                    Button(action: {

                        let url: NSURL = URL(string: self.repo.defaultBranch.lastBuild?.commit.compareUrl ?? "")! as NSURL

                        UIApplication.shared.open(url as URL)

                    }) {
                        Text(verbatim: "Compare " + String(repo.defaultBranch.lastBuild?.commit.compareUrl.split(separator: "/")[5] ?? ""))
                    }
                    HStack {
                        Image(systemName: "arrow.branch")
                        Text("Branch " + repo.defaultBranch.name)
                    }
                    
                }
                .padding(10)
                .multilineTextAlignment(.center)
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
            .padding(15)
            HStack {
                Button(action: {
                    
                    let url: NSURL = URL(string: "https://travis-ci.com/" + self.repo.slug + "/settings/")! as NSURL

                    UIApplication.shared.open(url as URL)
                    
                }) {
                    VStack {
                        Image(systemName: "gear")
                        Text("Manage")
                    }
                    .foregroundColor(Color.blue)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(5)
                }
                .padding(.leading, 15)
                .padding(.trailing, 1)
                
                Button(action: {print("Trash Tapped")}) {
                    VStack {
                        Image(systemName: "archivebox")
                        Text("Build History")
                    }
                    .foregroundColor(Color.blue)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(5)
                }
                .padding(.leading, 1)
                .padding(.trailing, 15)
            }
            Spacer()
            
            
        }
    }
}

struct RepoBuildDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepoBuildView(repo: Repository(id: 3, name: "repo2", slug: "matt43121/repo2", starred: true, defaultBranch: Branch(name: "Master", lastBuild: Build(id: 1, number: "2", state: "passed", duration: 53, startedAt: "", finishedAt: "", commit: Commit(id: 1, sha: "abc", ref: "def", message: "Message", compareUrl: "https://github.com", committedAt: "12/12/18"))), active: false))
    }
}
