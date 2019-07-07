//
//  TeamViewController.swift
//  Krowd9
//
//  Created by Javid Sheikh on 04/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit
import RxSwift

class TeamViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var foundedLabel: UILabel!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueCapacityLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet var allLabels: [UILabel]!
    @IBOutlet var subtitleLabels: [UILabel]!

    var viewModel: TeamViewModel!
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        styleView()
    }

    private func styleView() {
        view.backgroundColor = .black

        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cardView.layer.cornerRadius = 20.0
        cardView.layer.masksToBounds = true
        cardView.backgroundColor = Krowd9Color.red

        allLabels.forEach { $0.textColor = .white }
        teamNameLabel.font = UIFont(name: "AmericanTypewriter-Condensed", size: 28.0)
        subtitleLabels.forEach { $0.font = UIFont(name: "AmericanTypewriter-Condensed", size: 18.0) }
    }
}

extension TeamViewController: BindableType {
    func bindViewModel() {
        viewModel.logo
            .drive(logoImageView.rx.image)
            .disposed(by: bag)

        viewModel.teamName
            .map { NSAttributedString(string: $0, attributes: FontAttributes.cardTitle.attributes) }
            .drive(teamNameLabel.rx.attributedText)
            .disposed(by: bag)

        viewModel.founded
            .map { NSAttributedString(string: $0, attributes: FontAttributes.cardSubtitle.attributes) }
            .drive(foundedLabel.rx.attributedText)
            .disposed(by: bag)

        viewModel.venueName
            .map { NSAttributedString(string: $0, attributes: FontAttributes.cardSubtitle.attributes) }
            .drive(venueNameLabel.rx.attributedText)
            .disposed(by: bag)

        viewModel.capacity
            .map { NSAttributedString(string: $0, attributes: FontAttributes.cardSubtitle.attributes) }
            .drive(venueCapacityLabel.rx.attributedText)
            .disposed(by: bag)

        closeButton.rx.tap
            .take(1)
            .bind(to: viewModel.dismissAction.inputs)
            .disposed(by: bag)
    }
}
