//
//  Realm+Rx.swift
//  Krowd9
//
//  Created by Javid Sheikh on 05/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import RxSwift
import RealmSwift

extension ObservableType where Element: Object {
    func addToRealm(withId id: Int? = nil) -> Observable<Element> {
        return self.do(onNext: { object in
            let realm = RealmProvider.current.realm
            try? realm.write {
                if let team = object as? Team, let leagueId = id {
                    team.leagueId = leagueId
                }
                realm.add(object, update: .modified)
            }
        })
    }
}
