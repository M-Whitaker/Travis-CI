//
//  Repository.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 15/02/2020.
//  Copyright © 2020 Matt Whitaker. All rights reserved.
//

import Foundation

struct Commit: Codable {
    var id: Int
    var sha: String
    var ref: String
    var message: String
    var compareUrl: String
    var committedAt: String
}

struct Build: Identifiable, Codable {
    var id: Int
    var number: String
    var state: String
    var duration: Int
    var startedAt: String
    var finishedAt: String
    var commit: Commit
}

struct Branch: Codable {
//    var id: Int
    var name: String
    var lastBuild: Build?
//    var updatedAt: String
    
}

struct Repository: Identifiable, Codable {
    var id: Int
    var name: String
    var slug: String
    var description: String?
    var starred: Bool
    var defaultBranch: Branch
    var active: Bool
//    var buildNo: Int
}

struct Result: Codable {
    var repositories: [Repository]
}
