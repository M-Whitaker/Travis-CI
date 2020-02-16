//
//  SafariView.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 15/02/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let repo: Repository

    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC: SFSafariViewController = SFSafariViewController(url: URL(string: "https://github.com/" + repo.slug)!)
        return safariVC
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        uiViewController.dismissButtonStyle = .close
    }
}
