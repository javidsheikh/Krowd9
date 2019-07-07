//
//  NetworkService.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import Foundation
import RxSwift

struct NetworkService: NetworkingType {
    private let session: URLSession
    private let baseURL: Observable<String>

    private var headers: [String: String] {
        return  [
            "X-RapidAPI-Key": "2973497418msh1eb166ace76ccf2p1656b8jsnc9d11ccd2976",
            "Accept": "application/json"
        ]
    }

    init(configuration: URLSessionConfiguration, baseURL: String) {
        self.session = URLSession(configuration: configuration)
        self.baseURL = Observable.just(baseURL)
    }

    func decode<D: Decodable>(endpoint: Endpoint, type: D.Type) -> Observable<D> {
        return baseURL.flatMap { baseURL -> Observable<D> in
            let urlString = baseURL + endpoint.toURLString
            guard let url = URL(string: urlString) else { return .empty() }
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = self.headers
            return self.session.rx.decodable(request: request, type: D.self)
        }
    }
}
