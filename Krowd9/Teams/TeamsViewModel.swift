//
//  TeamsViewModel.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import Foundation
import RxSwift
import Action

struct TeamsViewModel {
    private let sceneCoordinator: SceneCoordinator
    private let networkService: NetworkService
    private let globalScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
    private let bag = DisposeBag()
    let title: Observable<String>
    let cellData: Observable<[Team]>

    init(sceneCoordinator: SceneCoordinator, networkService: NetworkService, model: League) {
        self.sceneCoordinator = sceneCoordinator
        self.networkService = networkService
        self.title = Observable.just(model.name)

        networkService.decode(endpoint: .teams(model.leagueId), type: TeamService.self)
            .observeOn(globalScheduler)
            .flatMap { service -> Observable<Team> in
                return Observable.create { observer in
                    service.api.teams.forEach { observer.onNext($0) }
                    return Disposables.create()
                }
            }
            .addToRealm(withId: model.leagueId)
            .subscribe()
            .disposed(by: bag)

        self.cellData = Observable.array(
            from: RealmProvider.current.realm.objects(Team.self)
                    .filter(NSPredicate(format: "leagueId = %d", model.leagueId))
                    .sorted(byKeyPath: "name")
        )
    }

    lazy var selectAction: Action<Team, Swift.Never> = { this in
        return Action { team in
            let teamViewModel = TeamViewModel(sceneCoordinator: this.sceneCoordinator, model: team)
            return this.sceneCoordinator
                .transition(to: Scene.team(teamViewModel), type: .modal(true))
                .asObservable()
        }
    }(self)
}
