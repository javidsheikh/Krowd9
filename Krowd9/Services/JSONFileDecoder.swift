//
//  JSONFileDecoder.swift
//  Krowd9
//
//  Created by Javid Sheikh on 07/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import Foundation

struct JSONFileDecoder {
    func decodeFromJSONFile<T: Decodable>(forEndpoint endpoint: Endpoint, toType type: T.Type) throws -> T {
        let url = try Path.inBundle(endpoint.description, withExtension: "json")
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: data)
            return model
        } catch {
            throw JSONError.unableToDecodeToType
        }
    }
}

enum JSONError: Error, LocalizedError {
    case fileNotFound
    case unableToDecodeToType

    var localizedDescription: String {
        switch self {
        case .fileNotFound: return "JSON file not found in main bundle"
        case .unableToDecodeToType: return "Could not decode data to type"
        }
    }
}
