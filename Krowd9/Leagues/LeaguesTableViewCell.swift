//
//  LeaguesTableViewCell.swift
//  Krowd9
//
//  Created by Javid Sheikh on 07/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func style(red: Bool, firstCell: Bool) {
        if firstCell {
            backgroundColor = .black
        } else {
            backgroundColor = !red ? Krowd9Color.red : Krowd9Color.gray
        }
        contentView.backgroundColor = red ? Krowd9Color.red : Krowd9Color.gray
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.layer.cornerRadius = 20.0
        contentView.layer.masksToBounds = true
    }
}
