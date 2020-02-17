//
//  User.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 15/02/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import Foundation

struct User: Identifiable, Codable {
    var id: Int
    var login: String
    var name: String
    var avatarUrl: String
}
