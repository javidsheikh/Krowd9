//
//  LeaguesViewModel.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import Foundation
import RxSwift
import Action

struct LeaguesViewModel {
    private let sceneCoordinator: SceneCoordinator
    private let networkService: NetworkingType
    private let globalScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
    private let bag = DisposeBag()
    let cellData: Observable<[League]>
    let title: Observable<String>

    init(sceneCoordinator: SceneCoordinator, networkService: NetworkingType, model: Country) {
        self.sceneCoordinator = sceneCoordinator
        self.networkService = networkService
        self.title = Observable.just(model.country)

        networkService.decode(endpoint: .leagues(model.country), type: LeagueService.self)
            .subscribeOn(globalScheduler)
            .flatMap { service -> Observable<League> in
                return Observable.create { observer in
                    service.api.leagues.forEach { observer.onNext($0) }
                    return Disposables.create()
                }
            }
            .addToRealm()
            .subscribe()
            .disposed(by: bag)

        self.cellData = Observable.array(
            from: RealmProvider.current.realm.objects(League.self).filter(NSPredicate(format: "country = %@", model.country))
        )
    }

    lazy var selectAction: Action<League, Swift.Never> = { this in
        return Action { league in
            let teamsViewModel = TeamsViewModel(sceneCoordinator: this.sceneCoordinator,
                                                networkService: this.networkService,
                                                model: league)
            return this.sceneCoordinator
                .transition(to: Scene.teams(teamsViewModel), type: .push(true))
                .asObservable()
        }
    }(self)
}
