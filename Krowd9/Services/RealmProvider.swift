//
//  RealmProvider.swift
//  Krowd9
//
//  Created by Javid Sheikh on 05/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmProvider {

    let configuration: Realm.Configuration

    internal init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }

    var realm: Realm {
        //swiftlint:disable force_try
        return try! Realm(configuration: configuration)
    }

    private static let userConfig = Realm.Configuration(fileURL: try! Path.inLibrary("Krowd9.realm"),
                                                                schemaVersion: 1,
                                                                deleteRealmIfMigrationNeeded: true,
                                                                objectTypes: [Country.self,
                                                                              League.self,
                                                                              Team.self
    ])
    //swiftlint:enable force_try

    public static var current: RealmProvider = {
        return RealmProvider(configuration: userConfig)
    }()
}
