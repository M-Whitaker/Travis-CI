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
            Text(String(repo.defaultBranch.lastBuild?.duration ?? 0))
            Text(repo.defaultBranch.lastBuild?.finishedAt ?? "")
            Text(convertTime(isoDate: repo.defaultBranch.lastBuild!.finishedAt).timeAgoDisplay())
            Text(repo.defaultBranch.lastBuild?.commit.compareUrl ?? "")
        }
    }
}

//struct RepoBuildDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RepoBuildView(repo: Repository(id: 3, name: "repo2", slug: "matt43121/repo2", starred: true, defaultBranch: Branch(name: "Master", lastBuild: Build(id: 1, number: "2", state: "passed", duration: 53, startedAt: "", finishedAt: "")), active: false))
//    }
//}
