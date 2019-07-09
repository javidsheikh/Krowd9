//
//  CountriesViewController.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

final class CountriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: CountriesViewModel!
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(forTableViewCell: CustomTableViewCell.self), forCellReuseIdentifier: "customCell")

        styleTableView()
    }

    private func styleTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = Krowd9Color.gray
    }
}

extension CountriesViewController: BindableType {
    func bindViewModel() {
        viewModel.title
            .observeOn(MainScheduler.instance)
            .bind(to: self.rx.title)
            .disposed(by: bag)

        viewModel.cellData
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items) { tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                //swiftlint:disable force_cast
                let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
                //swiftlint:enable force_cast
                cell.selectionStyle = .none

                let attributedText = NSAttributedString(string: element.country,
                                                        attributes: Krowd9FontAttributes.cellTitle.attributes)
                cell.nameLabel.attributedText = attributedText
                cell.logoImageView.image = UIImage()
                cell.styleCell(red: row % 2 == 0, firstCell: row == 0)
                return cell
            }
            .disposed(by: bag)

        tableView.rx.modelSelected(Country.self)
            .observeOn(MainScheduler.instance)
            .bind(to: viewModel.selectAction.inputs)
            .disposed(by: bag)

    }
}
