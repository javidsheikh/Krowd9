//
//  NetworkingType.swift
//  Krowd9
//
//  Created by Javid Sheikh on 07/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkingType {
    func decode<D: Decodable>(endpoint: Endpoint, type: D.Type) -> Observable<D>
}
