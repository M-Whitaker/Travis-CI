//
//  Build.swift
//  Travis-CI
//
//  Created by Matt Whitaker on 06/02/2021.
//  Copyright © 2021 Matt Whitaker. All rights reserved.
//

import Foundation

func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "")
            .replacingOccurrences(of: "\"", with: "")
 }
