//
//  Team.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

import RealmSwift

class Team: Object, Decodable {
    @objc dynamic var teamId: Int = 0
    @objc dynamic var name = ""
    @objc private dynamic var _logo: String?
    var founded = RealmOptional<Int>()
    @objc dynamic var venueName: String?
    var venueCapacity = RealmOptional<Int>()
    @objc dynamic var leagueId: Int = 0

    var logo: UIImage {
        guard let logoURLString = _logo, let image = UIImage(urlString: logoURLString) else {
            return UIImage(named: "error")!
        }
        return image
    }

    private enum CodingKeys: String, CodingKey {
        case teamId = "team_id"
        case name
        case logo
        case founded
        case venueName = "venue_name"
        case venueCapacity = "venue_capacity"
    }

    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let teamId = try container.decode(Int.self, forKey: .teamId)
        let name = try container.decode(String.self, forKey: .name)
        let logo = try container.decodeIfPresent(String.self, forKey: .logo)
        let founded = try container.decodeIfPresent(Int.self, forKey: .founded)
        let venueName = try container.decodeIfPresent(String.self, forKey: .venueName)
        let venueCapacity = try container.decodeIfPresent(Int.self, forKey: .venueCapacity)

        self.init(teamId: teamId, name: name, logo: logo, founded: RealmOptional<Int>(founded), venueName: venueName, venueCapacity: RealmOptional<Int>(venueCapacity))
    }

    convenience init(teamId: Int, name: String, logo: String?, founded: RealmOptional<Int>, venueName: String?, venueCapacity: RealmOptional<Int>) {
        self.init()

        self.teamId = teamId
        self.name = name
        self._logo = logo
        self.founded = founded
        self.venueName = venueName
        self.venueCapacity = venueCapacity
    }

    override static func primaryKey() -> String? {
        return "teamId"
    }
}

struct TeamService: Decodable {
    let api: API

    struct API: Decodable {
        let teams: [Team]
    }
}
/*
"team_id":53
"name":"Reading"
"code":NULL
"logo":"https://www.api-football.com/public/teams/53.png"
"country":"England"
"founded":1871
"venue_name":"Madejski Stadium"
"venue_surface":"grass"
"venue_address":"Shooters Way / Junction 11, M4"
"venue_city":"Reading, Berkshire"
"venue_capacity":24200
*/
