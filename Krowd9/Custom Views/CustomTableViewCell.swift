//
//  CustomTableViewCell.swift
//  Krowd9
//
//  Created by Javid Sheikh on 07/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    func styleCell(red: Bool, firstCell: Bool, hideImageView: Bool = false) {
        if firstCell {
            backgroundColor = Krowd9Color.gray
        } else {
            backgroundColor = !red ? Krowd9Color.red : Krowd9Color.gray
        }
        contentView.backgroundColor = red ? Krowd9Color.red : Krowd9Color.gray
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.layer.cornerRadius = 20.0
        contentView.layer.masksToBounds = true
    }
}
