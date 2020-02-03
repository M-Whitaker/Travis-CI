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
    
    var body: some View {
        VStack(alignment: .leading) {
                HStack {
                    Image(systemName: repo.active ? "checkmark" : "exclamationmark")
                    Text(repo.slug)
                    Spacer()
                    HStack {
                        Image(systemName: "number")
                        Text(repo.name)
                    }
                }.foregroundColor(repo.active ? .green : .yellow)
//                Text(repo.defaultBranch.name)
                HStack {
                    Image(systemName: "clock")
                    Text("Duration: About an hour ago")
                    Spacer()
                    if repo.starred {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    }
                }
                HStack {
                    Image(systemName: "calendar")
                    Text("Finished: About an hour ago")
                }
            }
    }
}

struct RepoBuildView_Previews: PreviewProvider {
    static var previews: some View {
        RepoBuildView(repo: Repository(id: 3, name: "repo2", slug: "matt43121/repo2", starred: true, defaultBranch: Branch(name: "Master", lastBuild: Build(id: 1, number: "2", state: "Passing")), active: false))
    }
}
