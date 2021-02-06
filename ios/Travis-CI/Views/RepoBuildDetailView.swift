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
    
    let builds = [
        Build(id: 0, number: "13", state: "passed", duration: 12051, startedAt: "02/03/05", finishedAt: "02/03/05", commit: Commit(id: 1, sha: "125125", ref: "1251252", message: "Message", compareUrl: "https://google.com", committedAt: "04/02/05"))
    ]
    
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
            Divider()
            List (builds) { build in
                Text(build.number)
            }
            
            
            
        }
    }
}
