//
//  TeamViewModel.swift
//  Krowd9
//
//  Created by Javid Sheikh on 04/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxSwiftExt
import Action

struct TeamViewModel {
    private let model: Team
    private let sceneCoordinator: SceneCoordinator

    init(sceneCoordinator: SceneCoordinator, model: Team) {
        self.model = model
        self.sceneCoordinator = sceneCoordinator
    }

    var logo: Driver<UIImage> {
        return Observable.just(model.logo)
            .asDriver(onErrorJustReturn: UIImage())
    }

    var teamName: Driver<String> {
        return Observable.just(model.name)
            .asDriver(onErrorJustReturn: "Error")
    }

    var founded: Driver<String> {
        return Observable.just(model.founded.value)
            .unwrap()
            .map { "Founded: \($0)" }
            .asDriver(onErrorJustReturn: "Error")
    }

    var venueName: Driver<String> {
        return Observable.just(model.venueName)
            .unwrap()
            .map { "Stadium: \($0)" }
            .asDriver(onErrorJustReturn: "Error")
    }

    var capacity: Driver<String> {
        return Observable.just(model.venueCapacity.value)
            .unwrap()
            .map { "Capacity: \($0)" }
            .asDriver(onErrorJustReturn: "Error")
    }

    lazy var dismissAction: Action<Void, Swift.Never> = { this in
        return Action { _ in
            return this.sceneCoordinator
                .pop()
                .asObservable()
        }
    }(self)

}
