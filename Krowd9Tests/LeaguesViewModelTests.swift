//
//  LeaguesViewModelTests.swift
//  Krowd9Tests
//
//  Created by Javid Sheikh on 07/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import Krowd9

class LeaguesViewModelTests: QuickSpec {
    
    override func spec() {
        var viewModel: LeaguesViewModel!
        var sceneCoordinator: SceneCoordinator!
        var networkService: NetworkingType!
        var country: Country!
        
        beforeEach {
            sceneCoordinator = SceneCoordinator(window: UIApplication.shared.keyWindow!)
            networkService = MockNetworkService()
            country = Country(country: "England", code: "GB", flag: nil)
            viewModel = LeaguesViewModel(sceneCoordinator: sceneCoordinator, networkService: networkService, model: country)
            
        }
        
        describe("view model is initialized") {
            context("subscribe to cell data observable") {
                it("should contain 6 rows") {
                    viewModel.cellData
                        .subscribe(onNext: {
                            expect($0.count).to(equal(6))
                        })
                        .disposed(by: DisposeBag())
                }
                it("cell 0 should be Premier League") {
                    let expectedLeague = League(leagueId: 2, name: "Premier League", logo: nil, country: "England")
                    var result: League!
                    viewModel.cellData
                        .subscribe(onNext: {
                            result = $0[0]
                        })
                        .disposed(by: DisposeBag())
                    
                    expect(result.leagueId).to(equal(expectedLeague.leagueId))
                    expect(result.name).to(equal(expectedLeague.name))
                    expect(result.country).to(equal(expectedLeague.country))
                }
            }
        }
    }
}
