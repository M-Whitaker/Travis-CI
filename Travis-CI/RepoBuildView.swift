//
//  RepoBuildView.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 26/01/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import SwiftUI

struct RepoBuildView: View {
    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Image("icons8-checkmark-50")
                    Text("matt43121/travis-ci")
                    Spacer()
                    Text("# 12345")
                }.foregroundColor(.green)
                HStack {
                    Image(systemName: "clock")
                    Text("Duration: About an hour ago")
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
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
        RepoBuildView()
    }
}
