//
//  CountriesViewModel.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm
import Action

struct CountriesViewModel {

    private let sceneCoordinator: SceneCoordinator
    private let networkService: NetworkingType
    private let globalScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
    private let bag = DisposeBag()
    let title: Observable<String>
    let countriesObservable: Observable<Country>
    let cellData: Observable<[Country]>

    init(sceneCoordinator: SceneCoordinator, networkService: NetworkingType) {
        self.sceneCoordinator = sceneCoordinator
        self.networkService = networkService
        self.title = Observable.just("Countries")

        self.countriesObservable = networkService.decode(endpoint: .countries, type: CountryService.self)
            .observeOn(globalScheduler)
            .flatMap { service -> Observable<Country> in
                return Observable.create { observer in
                    service.api.countries.forEach { observer.onNext($0) }
                    return Disposables.create()
                }
            }
            .share(replay: 1, scope: .forever)

        self.countriesObservable
            .filter({ country in
                let realm = RealmProvider.current.realm
                return realm.objects(Country.self).filter(NSPredicate(format: "country = %@", country.country)).isEmpty
            })
            .addToRealm()
            .subscribe()
            .disposed(by: bag)

        self.cellData = Observable.array(from: RealmProvider.current.realm.objects(Country.self))
    }

    lazy var selectAction: Action<Country, Swift.Never> = { this in
        return Action { country in
            let leaguesViewModel = LeaguesViewModel(sceneCoordinator: this.sceneCoordinator,
                                                    networkService: this.networkService,
                                                    model: country)
            return this.sceneCoordinator
                .transition(to: Scene.leagues(leaguesViewModel), type: .push(true))
                .asObservable()
        }
    }(self)
}
