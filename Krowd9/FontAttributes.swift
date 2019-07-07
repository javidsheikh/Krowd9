//
//  FontAttributes.swift
//  Krowd9
//
//  Created by Javid Sheikh on 07/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit

enum FontAttributes {
    case navBarTitle, cellTitle, cardTitle, cardSubtitle

    var attributes: [NSAttributedString.Key: Any] {
        switch self {
        case .navBarTitle:
            return [NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter-Condensed", size: 22.0) as Any]
        case .cellTitle:
            return [NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter-Condensed", size: 18.0) as Any]
        case .cardTitle:
            return [NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter-Condensed", size: 28.0) as Any]
        case .cardSubtitle:
            return [NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter-Condensed", size: 20.0) as Any]
        }
    }

}
