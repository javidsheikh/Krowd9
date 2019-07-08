//
//  TeamViewController.swift
//  Krowd9
//
//  Created by Javid Sheikh on 04/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit
import RxSwift

final class TeamViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var foundedLabel: UILabel!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueCapacityLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet var allLabels: [UILabel]!
    @IBOutlet var subtitleLabels: [UILabel]!

    var viewModel: TeamViewModel!
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        styleView()
    }

    override func viewDidLayoutSubviews() {
        presentationAnimtation()
    }

    private func styleView() {
        view.backgroundColor = .black

        cardViewTopConstraint.constant = (0.75 * view.bounds.size.height) - 48.0
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cardView.layer.cornerRadius = 20.0
        cardView.layer.masksToBounds = true
        cardView.backgroundColor = Krowd9Color.red
    }

    private func presentationAnimtation() {
        UIView.animate(withDuration: 0.8,
                       delay: 0.8,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseIn,
                       animations: {
            self.cardViewTopConstraint.constant = 36
            self.view.layoutIfNeeded()
        })
    }
}

extension TeamViewController: BindableType {
    func bindViewModel() {
        viewModel.logo
            .drive(logoImageView.rx.image)
            .disposed(by: bag)

        viewModel.teamName
            .map { NSAttributedString(string: $0, attributes: Krowd9FontAttributes.cardTitle.attributes) }
            .drive(teamNameLabel.rx.attributedText)
            .disposed(by: bag)

        viewModel.founded
            .map { NSAttributedString(string: $0, attributes: Krowd9FontAttributes.cardSubtitle.attributes) }
            .drive(foundedLabel.rx.attributedText)
            .disposed(by: bag)

        viewModel.venueName
            .map { NSAttributedString(string: $0, attributes: Krowd9FontAttributes.cardSubtitle.attributes) }
            .drive(venueNameLabel.rx.attributedText)
            .disposed(by: bag)

        viewModel.capacity
            .map { NSAttributedString(string: $0, attributes: Krowd9FontAttributes.cardSubtitle.attributes) }
            .drive(venueCapacityLabel.rx.attributedText)
            .disposed(by: bag)

        closeButton.rx.tap
            .take(1)
            .bind(to: viewModel.dismissAction.inputs)
            .disposed(by: bag)
    }
}
