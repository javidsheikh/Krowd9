//
//  LeaguesViewController.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit
import RxSwift

class LeaguesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: LeaguesViewModel!
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(forTableViewCell: LeaguesTableViewCell.self), forCellReuseIdentifier: "leagues")

        styleTableView()
    }

    private func styleTableView() {
        tableView.separatorStyle = .none
    }
}

extension LeaguesViewController: BindableType {
    func bindViewModel() {
        viewModel.title
            .subscribeOn(MainScheduler.instance)
            .bind(to: self.rx.title)
            .disposed(by: bag)

        viewModel.cellData
            .subscribeOn(MainScheduler.instance)
            .do(onNext: { [weak self] leagues in
                self?.tableView.backgroundColor = leagues.count % 2 == 0 ? Krowd9Color.gray : Krowd9Color.red
            })
            .bind(to: tableView.rx.items) { tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                //swiftlint:disable force_cast
                let cell = tableView.dequeueReusableCell(withIdentifier: "leagues", for: indexPath) as! LeaguesTableViewCell
                //swiftlint:enable force_cast
                cell.selectionStyle = .none

                let attributedText = NSAttributedString(string: element.name, attributes: FontAttributes.cellTitle.attributes)
                cell.nameLabel.attributedText = attributedText
                cell.logoImageView.image = element.logo
                cell.style(red: row % 2 == 0, firstCell: row == 0)
                return cell
            }
            .disposed(by: bag)

        tableView.rx.modelSelected(League.self)
            .subscribeOn(MainScheduler.instance)
            .bind(to: viewModel.selectAction.inputs)
            .disposed(by: bag)
    }
}
