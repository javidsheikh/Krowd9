//
//  TeamsViewModelTests.swift
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

class TeamsViewModelTests: QuickSpec {
    
    override func spec() {
        var viewModel: TeamsViewModel!
        var sceneCoordinator: SceneCoordinator!
        var networkService: NetworkingType!
        var league: League!
        
        beforeEach {
            sceneCoordinator = SceneCoordinator(window: UIApplication.shared.keyWindow!)
            networkService = MockNetworkService()
            league = League(leagueId: 164, name: "League One", logo: nil, country: "England")
            viewModel = TeamsViewModel(sceneCoordinator: sceneCoordinator, networkService: networkService, model: league)
            
        }
        describe("view model is initialized") {
            context("subscribe to cell data observable") {
                it("should contain 24 items") {
                    viewModel.cellData
                        .subscribe(onNext: {
                            expect($0.count).to(equal(24))
                        })
                        .disposed(by: DisposeBag())
                }
                it("cell 0 should be Premier League") {
                    let expectedTeam = Team(teamId: 1335, name: "Charlton", logo: nil, founded: RealmOptional<Int>(1905), venueName: "The Valley", venueCapacity: RealmOptional<Int>(27111))
                    var result: Team!
                    viewModel.cellData
                        .subscribe(onNext: {
                            result = $0[7]
                        })
                        .disposed(by: DisposeBag())
                    
                    expect(result.teamId).to(equal(expectedTeam.teamId))
                    expect(result.name).to(equal(expectedTeam.name))
                    expect(result.founded.value).to(equal(expectedTeam.founded.value))
                    expect(result.venueName).to(equal(expectedTeam.venueName))
                    expect(result.venueCapacity.value).to(equal(expectedTeam.venueCapacity.value))
                }
            }
        }
    }
}
