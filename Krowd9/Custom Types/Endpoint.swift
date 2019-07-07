//
//  Endpoint.swift
//  Krowd9
//
//  Created by Javid Sheikh on 02/07/2019.
//  Copyright © 2019 QuaxoDigital. All rights reserved.
//

enum Endpoint: CustomStringConvertible {
    case countries
    case leagues(String)
    case teams(Int)

    var description: String {
        switch  self {
        case .countries: return "countries"
        case .leagues: return "leagues"
        case .teams: return "teams"
        }
    }

    var toURLString: String {
        switch self {
        case .countries: return "countries"
        case .leagues(let country): return "leagues/country/\(country)/2018"
        case .teams(let leagueId): return "/teams/league/\(leagueId)"
        }
    }
}
