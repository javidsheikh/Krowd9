//
//  Path.swift
//  Krowd9
//
//  Created by Javid Sheikh on 04/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import Foundation

class Path {
    static func inLibrary(_ name: String) throws -> URL {
        return try FileManager.default
            .url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(name)
    }
}
