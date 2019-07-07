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

class CountriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: CountriesViewModel!
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        styleTableView()
    }

    private func styleTableView() {
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.separatorInset = UIEdgeInsets.zero
    }
}

extension CountriesViewController: BindableType {
    func bindViewModel() {
        viewModel.title
            .subscribeOn(MainScheduler.instance)
            .bind(to: self.rx.title)
            .disposed(by: bag)

        viewModel.cellData
            .subscribeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items) { _, _, element in
                let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
                cell.selectionStyle = .none
                cell.backgroundColor = .gray
                let attributedText = NSAttributedString(string: element.country,
                                                        attributes: FontAttributes.cellTitle.attributes)
                cell.textLabel?.attributedText = attributedText
                cell.accessoryType = .disclosureIndicator
                return cell
            }
            .disposed(by: bag)

        tableView.rx.modelSelected(Country.self)
            .subscribeOn(MainScheduler.instance)
            .bind(to: viewModel.selectAction.inputs)
            .disposed(by: bag)

    }
}
