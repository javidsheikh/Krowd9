//
//  UINib+init.swift
//  Krowd9
//
//  Created by Javid Sheikh on 03/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit

extension UINib {
    convenience init<T: UITableViewCell>(forTableViewCell cell: T.Type) {
        guard let nibName = cell.description().components(separatedBy: ".").last else {
            fatalError("Unable to load nib. Please check nib name.")
        }
        self.init(nibName: nibName, bundle: nil)
    }

    convenience init<T: UICollectionViewCell>(forCollectionViewCell cell: T.Type) {
        guard let nibName = cell.description().components(separatedBy: ".").last else {
            fatalError("Unable to load nib. Please check nib name.")
        }
        self.init(nibName: nibName, bundle: nil)
    }
}
