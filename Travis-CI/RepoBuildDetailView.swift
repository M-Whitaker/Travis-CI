//
//  RepoBuildDetailView.swift
//  Travis-CI
//
//  Created by Adrian Whitaker on 31/01/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import SwiftUI

struct RepoBuildDetailView: View {
    let repo: Repository
    
    var body: some View {
        Text(repo.name)
    }
}

struct RepoBuildDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepoBuildDetailView(repo: Repository(name: "repo1", slug: "matt43121/repo2", url: "https://example2.com", favourite: true, default_branch: Branch(name: "Master"), passing: false, buildNo: 5678, duration: 600, Finished: 1920))
    }
}
