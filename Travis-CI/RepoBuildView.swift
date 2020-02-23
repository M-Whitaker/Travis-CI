//
//  RepoBuildView.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 26/01/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import SwiftUI

struct RepoBuildView: View {
    let repo: Repository
    
    func isPassing() -> Bool {
        if repo.defaultBranch.lastBuild != nil {
            if repo.defaultBranch.lastBuild?.state == "passed" {
                return true
            } else {
                return false
            }
        } else {
            return true
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if repo.defaultBranch.lastBuild != nil {
                    HStack {
                        Image(systemName: isPassing() ? "checkmark" : "exclamationmark")
                        Text(repo.slug)
                        Spacer()
                        HStack {
                            Image(systemName: "number")
                            Text(repo.defaultBranch.lastBuild?.number ?? "0")
                        }
                    }.foregroundColor(isPassing() ? .green : .yellow)
                Text("Default Branch: \(repo.defaultBranch.name ) Last Build: \(repo.defaultBranch.lastBuild?.state ?? "Not ran yet")" )
                    HStack {
                        Image(systemName: "calendar")
                        Text("Finished: About an hour ago")
                        Spacer()
                        if repo.starred {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        }
                    }
            } else {
                Text(repo.slug)
            }
        }
    }
}

//struct RepoBuildView_Previews: PreviewProvider {
//    static var previews: some View {
//        RepoBuildView(repo: Repository(id: 3, name: "repo2", slug: "matt43121/repo2", starred: true, defaultBranch: Branch(name: "Master", lastBuild: Build(id: 1, number: "2", state: "passed", duration: 53, startedAt: "", finishedAt: "")), active: false))
//    }
//}
