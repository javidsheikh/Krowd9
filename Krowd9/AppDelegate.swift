//
//  AppDelegate.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Krowd9ThemeOptions.prepareAppearance()

        let baseURL = "https://api-football-v1.p.rapidapi.com/v2/"
        let networkService = NetworkService(configuration: .default, baseURL: baseURL)
        let sceneCoordinator = SceneCoordinator(window: window!)
        let countriesViewModel = CountriesViewModel(sceneCoordinator: sceneCoordinator, networkService: networkService)
        let firstScene = Scene.countries(countriesViewModel)
        sceneCoordinator.transition(to: firstScene, type: .root)

        return true
    }
}
