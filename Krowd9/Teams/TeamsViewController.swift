//
//  TeamsViewController.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit
import RxSwift

class TeamsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: TeamsViewModel!
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self

        collectionView.register(UINib(forCollectionViewCell: TeamsCollectionViewCell.self), forCellWithReuseIdentifier: "team")

        styleCollectionView()
    }

    private func styleCollectionView() {
        collectionView.backgroundColor = .black
    }
}

extension TeamsViewController: BindableType {
    func bindViewModel() {
        viewModel.title
            .subscribeOn(MainScheduler.instance)
            .bind(to: self.rx.title)
            .disposed(by: bag)

        viewModel.cellData
            .subscribeOn(MainScheduler.instance)
            .bind(to: collectionView.rx.items) { collectionView, item, element in
                let indexPath = IndexPath(item: item, section: 0)
                //swiftlint:disable force_cast
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "team",
                                                              for: indexPath) as! TeamsCollectionViewCell
                //swiftlint:enable force_cast
                cell.contentView.backgroundColor = .black
                cell.logoImageView.image = element.logo
                return cell
            }
            .disposed(by: bag)

        collectionView.rx.modelSelected(Team.self)
            .subscribeOn(MainScheduler.instance)
            .bind(to: viewModel.selectAction.inputs)
            .disposed(by: bag)
    }
}

extension TeamsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width / 2 - 10, height: collectionView.bounds.size.height / 2 - 10)
    }

}
