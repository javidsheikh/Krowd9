//
//  MockNetworkService.swift
//  Krowd9
//
//  Created by Javid Sheikh on 07/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import RxSwift

struct MockNetworkService: NetworkingType {

    func decode<D: Decodable>(endpoint: Endpoint, type: D.Type) -> Observable<D> {
        let jsonFileDecoder = JSONFileDecoder()
        guard let service = try? jsonFileDecoder.decodeFromJSONFile(forEndpoint: endpoint, toType: D.self) else {
            return .empty()
        }
        return Observable.just(service)
    }
}
