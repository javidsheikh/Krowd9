//
//  CountriesViewModelTests.swift
//  Krowd9Tests
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import Krowd9

class CountriesViewModelTests: QuickSpec {
    
    override func spec() {
        var viewModel: CountriesViewModel!
        var sceneCoordinator: SceneCoordinator!
        var networkService: NetworkingType!
        
        beforeEach {
            sceneCoordinator = SceneCoordinator(window: UIApplication.shared.keyWindow!)
            networkService = MockNetworkService()
            viewModel = CountriesViewModel(sceneCoordinator: sceneCoordinator, networkService: networkService)

        }
        
        describe("view model is initialized") {
            context("subscribe to cell data observable") {
                it("should contain 103 rows") {
                    viewModel.cellData
                        .subscribe(onNext: {
                            expect($0.count).to(equal(103))
                        })
                        .disposed(by: DisposeBag())
                }
                it("cell 3 should be Argentina") {
                    let expectedCountry = Country(country: "Argentina", code: "AR", flag: "https://www.api-football.com/public/flags/ar.svg")
                    var result: Country!
                    viewModel.cellData
                        .subscribe(onNext: {
                            result = $0[3]
                        })
                        .disposed(by: DisposeBag())
                    
                    expect(result.country).to(equal(expectedCountry.country))
                    expect(result.code).to(equal(expectedCountry.code))
                    expect(result.flag).to(equal(expectedCountry.flag))
                }
            }
        }
    }
}
