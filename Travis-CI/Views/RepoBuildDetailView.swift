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
            HStack {
                Button(action: {

                    let url: NSURL = URL(string: "https://github.com/" + self.repo.slug + "/commit/" + (self.repo.defaultBranch.lastBuild?.commit.sha ?? ""))! as NSURL

                    UIApplication.shared.open(url as URL)

                }) {
                    HStack {
                        Image(systemName: "shuffle")
                        Text(verbatim: String("Commit " + (repo.defaultBranch.lastBuild?.commit.sha.prefix(7) ?? "") ))
                        Image(systemName: "shuffle")
                    }
                    
                }
                Text(printSecondsToHoursMinutesSeconds(seconds: repo.defaultBranch.lastBuild?.duration ?? 0))
                Text("Debug")
            }
            Text(repo.defaultBranch.name)
            Text(convertTime(isoDate: repo.defaultBranch.lastBuild?.finishedAt ?? "").description)
            Text(convertTime(isoDate: repo.defaultBranch.lastBuild!.finishedAt).timeAgoDisplay())
            Button(action: {

                let url: NSURL = URL(string: self.repo.defaultBranch.lastBuild?.commit.compareUrl ?? "")! as NSURL

                UIApplication.shared.open(url as URL)

            }) {
                Text(verbatim: String(repo.defaultBranch.lastBuild?.commit.compareUrl.split(separator: "/")[5] ?? ""))
            }
            
        }
    }
}

struct RepoBuildDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepoBuildView(repo: Repository(id: 3, name: "repo2", slug: "matt43121/repo2", starred: true, defaultBranch: Branch(name: "Master", lastBuild: Build(id: 1, number: "2", state: "passed", duration: 53, startedAt: "", finishedAt: "", commit: Commit(id: 1, sha: "abc", ref: "def", message: "Message", compareUrl: "https://github.com", committedAt: "12/12/18"))), active: false))
    }
}
