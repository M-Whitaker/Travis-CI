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
    
    func isPassing() -> Dictionary<String, Any> {
        if repo.defaultBranch.lastBuild != nil {
            if repo.defaultBranch.lastBuild?.state == "passed" {
                return ["icon": "checkmark", "colour": Color.green]
            } else if repo.defaultBranch.lastBuild?.state == "errored" {
                return ["icon": "exclamationmark", "colour": Color.yellow]
            } else {
                return ["icon": "xmark", "colour": Color.red]
            }
        } else {
            return ["icon": "arrow.clockwise", "colour": Color.gray]
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if repo.defaultBranch.lastBuild != nil {
                    HStack {
                        Image(systemName: isPassing()["icon"] as! String)
                        Text(repo.slug)
                        Spacer()
                        HStack {
                            Image(systemName: "number")
                            Text(repo.defaultBranch.lastBuild?.number ?? "0")
                        }
                    }.foregroundColor(isPassing()["colour"] as? Color)
                Text("Default Branch: \(repo.defaultBranch.name ) Last Build: \(repo.defaultBranch.lastBuild?.state.capitalized ?? "Not ran yet")" )
                    HStack {
                        Image(systemName: "calendar")
                        Text("Finished about \(convertTime(isoDate: repo.defaultBranch.lastBuild!.finishedAt).timeAgoDisplay())")
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
