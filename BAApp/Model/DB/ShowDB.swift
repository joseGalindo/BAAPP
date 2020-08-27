//
//  ShowDB.swift
//  BAApp
//
//  Created by Jose Galindo martinez on 25/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import Foundation
import RealmSwift

class ShowDB: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var summary = ""
    @objc dynamic var originalImage = ""
    @objc dynamic var mediumImage = ""
    @objc dynamic var rate = 0.0
    @objc dynamic var showPage = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    init(show: Show) {
        id = show.id!
        name = show.name!
        summary = show.summary!
        originalImage = show.image?.original ?? ""
        mediumImage = show.image?.medium ?? ""
        rate = show.rating?.average ?? 0.0
        showPage = show.externals?.imdb ?? ""
    }
    
    func toShow() -> Show {
        return Show(id: id, url: nil, name: self.name, type: nil, language: nil, genres: nil, status: nil, runtime: nil, premiered: nil, officialSite: nil, schedule: nil, rating: Rating(average: rate), weight: nil, network: nil, externals: External(tvrage: nil, thetvdb: nil, imdb: showPage), image: Image(medium: mediumImage, original: originalImage), summary: summary, updated: nil)
    }
    
    required init() {
    }
}
