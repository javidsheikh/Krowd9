//
//  TeamViewModelTests.swift
//  Krowd9Tests
//
//  Created by Javid Sheikh on 07/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RealmSwift
@testable import Krowd9

class TeamViewModelTests: QuickSpec {
    
    override func spec() {
        var viewModel: TeamViewModel!
        var sceneCoordinator: SceneCoordinator!
        var team: Team!
        
        beforeEach {
            sceneCoordinator = SceneCoordinator(window: UIApplication.shared.keyWindow!)
            team = Team(teamId: 1335, name: "Charlton", logo: nil, founded: RealmOptional<Int>(1905), venueName: "The Valley", venueCapacity: RealmOptional<Int>(27111))
            viewModel = TeamViewModel(sceneCoordinator: sceneCoordinator, model: team)
            
        }

        describe("view model is initialized") {
            context("team name") {
                it("should be Charlton") {
                    viewModel.teamName
                        .asObservable()
                        .subscribe(onNext: {
                            expect($0).to(equal("Charlton"))
                        })
                        .disposed(by: DisposeBag())
                }
            }
            context("founded") {
                it("should be 1905") {
                    viewModel.founded
                        .asObservable()
                        .subscribe(onNext: {
                            expect($0).to(equal("Founded: 1905"))
                        })
                        .disposed(by: DisposeBag())
                }
            }
            context("venue name") {
                it("should be The Valley") {
                    viewModel.venueName
                        .asObservable()
                        .subscribe(onNext: {
                            expect($0).to(equal("Stadium: The Valley"))
                        })
                        .disposed(by: DisposeBag())
                }
            }
            context("capacity") {
                it("should be 27111") {
                    viewModel.capacity
                        .asObservable()
                        .subscribe(onNext: {
                            expect($0).to(equal("Capacity: 27111"))
                        })
                        .disposed(by: DisposeBag())
                }
            }
        }
    }
}
