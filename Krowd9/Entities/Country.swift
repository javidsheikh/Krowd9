//
//  Country.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import RealmSwift

final class Country: Object, Decodable {
    @objc dynamic var country = ""
    @objc dynamic var code: String?
    @objc dynamic var flag: String?

    private enum CodingKeys: String, CodingKey {
        case country, code, flag
    }

    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let country = try container.decode(String.self, forKey: .country)
        let code = try container.decodeIfPresent(String.self, forKey: .code)
        let flag = try container.decodeIfPresent(String.self, forKey: .flag)

        self.init(country: country, code: code, flag: flag)
    }

    convenience init(country: String, code: String?, flag: String?) {
        self.init()

        self.country = country
        self.code = code
        self.flag = flag
    }

    override static func primaryKey() -> String? {
        return "country"
    }
}

class CountryService: Decodable {
    let api: API

    class API: Decodable {
        let countries: [Country]
    }
}
