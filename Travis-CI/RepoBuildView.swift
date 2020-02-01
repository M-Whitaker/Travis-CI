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
                    Image(systemName: repo.passing ? "checkmark" : "exclamationmark")
                    Text(repo.slug)
                    Spacer()
                    HStack {
                        Image(systemName: "number")
                        Text(repo.name)
                    }
                }.foregroundColor(repo.passing ? .green : .yellow)
                Text(repo.default_branch.name)
                HStack {
                    Image(systemName: "clock")
                    Text("Duration: About an hour ago")
                    Spacer()
                    if repo.favourite {
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
        RepoBuildView(repo: Repository(name: "repo2", slug: "matt43121/repo2", url: "https://example2.com", favourite: true, default_branch: Branch(name: "Master"), passing: false, buildNo: 5678, duration: 600, Finished: 1920))
    }
}
