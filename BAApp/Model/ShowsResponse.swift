//
//  ShowsResponse.swift
//  BAApp
//
//  Created by Jose Galindo martinez on 24/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import Foundation

struct Show : Decodable {
    let id : Int?
    let url : String?
    let name : String?
    let type : String?
    let language : String?
    let genres : [String]?
    let status: String?
    let runtime: Int?
    let premiered: String?
    let officialSite: String?
    let schedule : Schedule?
    let rating : Rating?
    let weight: Int?
    let network: Network?
    let externals: External?
    let image: Image?
    let summary: String?
    let updated: Int64?
}

struct Schedule : Decodable {
    let time: String?
    let days: [String]?
}

struct Rating: Decodable {
    let average: Double?
}

struct Network: Decodable {
    let id: Int?
    let name: String?
}

struct External: Decodable {
    let tvrage: Int?
    let thetvdb: Int?
    let imdb: String?
}

struct Image: Decodable {
    let medium: String?
    let original: String?
}
