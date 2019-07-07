//
//  Scene+ViewController.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit

extension Scene {
    func viewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        switch self {
        case .countries(let viewModel):
            // swiftlint:disable force_cast
            let navController = storyboard.instantiateViewController(withIdentifier: "Countries") as! UINavigationController
            var viewController = navController.viewControllers.first as! CountriesViewController
            viewController.bindViewModel(to: viewModel)
            return navController

        case .leagues(let viewModel):
            var viewController = storyboard.instantiateViewController(withIdentifier: "Leagues") as! LeaguesViewController
            viewController.bindViewModel(to: viewModel)
            return viewController

        case .teams(let viewModel):
            var viewController = storyboard.instantiateViewController(withIdentifier: "Teams") as! TeamsViewController
            viewController.bindViewModel(to: viewModel)
            return viewController

        case .team(let viewModel):
            var viewController = storyboard.instantiateViewController(withIdentifier: "Team") as! TeamViewController
            // swiftlint:enable force_cast
            viewController.bindViewModel(to: viewModel)
            return viewController
        }
    }
}
