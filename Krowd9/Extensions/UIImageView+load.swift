//
//  UIImageView+load.swift
//  Krowd9
//
//  Created by Javid Sheikh on 04/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import UIKit

//extension UIImageView {
//    func load(urlString: String) {
//        DispatchQueue.global().async { [weak self] in
//            if let url = URL(string: urlString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self?.image = image
//                }
//            }
//        }
//    }
//}

extension UIImage {
    convenience init?(urlString: String) {
        guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else {
            return nil
        }
        self.init(data: data)
    }
}
