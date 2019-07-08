//
//  TeamsViewController.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit
import RxSwift

final class TeamsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: TeamsViewModel!
    private let bag = DisposeBag()
    private var loadView: UIView?
    private let transitionAnimator = LogoAnimator()

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

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
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

extension TeamsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        guard let selectedIndexPathCell = collectionView.indexPathsForSelectedItems?.first,
            let selectedCell = collectionView.cellForItem(at: selectedIndexPathCell),
            let selectedCellSuperview = selectedCell.superview else {
                return nil
        }

        transitionAnimator.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        transitionAnimator.originFrame = CGRect(
            x: transitionAnimator.originFrame.origin.x,
            y: transitionAnimator.originFrame.origin.y,
            width: transitionAnimator.originFrame.size.width,
            height: transitionAnimator.originFrame.size.height
        )

        transitionAnimator.presenting = true

        return transitionAnimator
    }
}
