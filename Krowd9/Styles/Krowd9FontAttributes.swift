//
//  Krowd9FontAttributes.swift
//  Krowd9
//
//  Created by Javid Sheikh on 07/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit

enum Krowd9FontAttributes {
    case navBarTitle, cellTitle, cardTitle, cardSubtitle

    var attributes: [NSAttributedString.Key: Any] {
        switch self {
        case .navBarTitle:
            return [NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "DINCondensed-Bold", size: 26.0) as Any]
        case .cellTitle:
            return [NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "DINCondensed-Bold", size: 22.0) as Any]
        case .cardTitle:
            return [NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "DINCondensed-Bold", size: 32.0) as Any]
        case .cardSubtitle:
            return [NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "DINCondensed-Bold", size: 22.0) as Any]
        }
    }

}
