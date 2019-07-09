//
//  LeaguesViewController.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit
import RxSwift

final class LeaguesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: LeaguesViewModel!
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(forTableViewCell: CustomTableViewCell.self), forCellReuseIdentifier: "customCell")

        styleTableView()
    }

    private func styleTableView() {
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    private func slideIn(cell: UITableViewCell, withDelay delay: CFTimeInterval) {
        let slideFromRight = CABasicAnimation(keyPath: "position.x")
        slideFromRight.fillMode = .backwards
        slideFromRight.fromValue = tableView.bounds.size.width * 1.5
        slideFromRight.toValue = tableView.bounds.size.width * 0.5
        slideFromRight.beginTime = CACurrentMediaTime() + delay

        cell.layer.add(slideFromRight, forKey: nil)
    }
}

extension LeaguesViewController: BindableType {
    func bindViewModel() {
        viewModel.title
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.title)
            .disposed(by: bag)

        viewModel.cellData
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] leagues in
                self?.tableView.backgroundColor = leagues.count % 2 == 0 ? Krowd9Color.gray : Krowd9Color.red
            })
            .bind(to: tableView.rx.items) { tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                //swiftlint:disable force_cast
                let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
                //swiftlint:enable force_cast
                cell.selectionStyle = .none

                let attributedText = NSAttributedString(string: element.name,
                                                        attributes: Krowd9FontAttributes.cellTitle.attributes)
                cell.nameLabel.attributedText = attributedText
                cell.logoImageView.image = element.logo
                cell.styleCell(red: row % 2 == 0, firstCell: row == 0)
                return cell
            }
            .disposed(by: bag)

        tableView.rx.modelSelected(League.self)
            .observeOn(MainScheduler.instance)
            .bind(to: viewModel.selectAction.inputs)
            .disposed(by: bag)
    }
}

extension LeaguesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        slideIn(cell: cell, withDelay: Double(indexPath.row + 1) * 0.2)
    }
}
