//
//  Krowd9ThemeOptions.swift
//  Krowd9
//
//  Created by Javid Sheikh on 07/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit

class Krowd9ThemeOptions {
    class func prepareAppearance() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = Krowd9FontAttributes.navBarTitle.attributes
    }
}
