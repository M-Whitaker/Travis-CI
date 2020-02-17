//
//  Settings.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 17/02/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import Foundation

class Settings: ObservableObject {
    @Published var authEnabled: Bool = UserDefaults.standard.bool(forKey: "authEnabled") {
        didSet {
            UserDefaults.standard.set(self.authEnabled, forKey: "authEnabled")
        }
    }
    @Published var token: String = UserDefaults.standard.string(forKey: "token") ?? "" {
        didSet {
            UserDefaults.standard.set(self.token, forKey: "token")
        }
    }
}
