//
//  League.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import RealmSwift

class League: Object, Decodable {
    @objc dynamic var leagueId: Int = 0
    @objc dynamic var name = ""
    //swiftlint:disable identifier_name
    @objc dynamic var _logo: Data?
    @objc dynamic var country = ""

    var logo: UIImage {
        guard let data = _logo, let image = UIImage(data: data) else {
            return UIImage(named: "error")!
        }
        return image
    }

    private enum CodingKeys: String, CodingKey {
        case leagueId = "league_id", name, logo, country
    }

    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let leagueId = try container.decode(Int.self, forKey: .leagueId)
        let name = try container.decode(String.self, forKey: .name)
        let logoURL = try container.decodeIfPresent(String.self, forKey: .logo)
        var _logo = Data()
        if let urlString = logoURL, let url = URL(string: urlString) {
            _logo = try Data(contentsOf: url)
        }
        let country = try container.decode(String.self, forKey: .country)

        self.init(leagueId: leagueId, name: name, logo: _logo, country: country)
    }

    convenience init(leagueId: Int, name: String, logo: Data?, country: String) {
        self.init()

        self.leagueId = leagueId
        self.name = name
        self._logo = logo
        self.country = country
        //swiftlint:ensable identifier_name
    }

    override static func primaryKey() -> String? {
        return "leagueId"
    }
}

struct LeagueService: Decodable {
    let api: API

    struct API: Decodable {
        let leagues: [League]
    }
}
