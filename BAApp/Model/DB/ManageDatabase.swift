//
//  ManageDatabase.swift
//  BAApp
//
//  Created by Jose Galindo martinez on 25/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import Foundation
import RealmSwift

class ManageDatabase : NSObject {
    @objc static let sharedInstance: ManageDatabase = {
        let instance = ManageDatabase()
        return instance
    }()
    
    func addShow(_ show : Show) {
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(ShowDB(show: show), update: .all)
        do {
            try realm.commitWrite()
        } catch let error {
            print("[LOG] Could not write to database: ", error)
        }
        NotificationCenter.default.post(name: Notification.Name(Constants.DATABASE_MODIFICATED), object: nil)
    }
    
    func deleteShow(show: Show) {
        let realm = try! Realm()
        do {
            let object = realm.objects(ShowDB.self).filter("id = %@", show.id!).first
            try realm.write {
                if let obj = object {
                    realm.delete(obj)
                }
            }
        } catch let error {
            print("[LOG] Could not write to database: ", error)
        }
        NotificationCenter.default.post(name: Notification.Name(Constants.DATABASE_MODIFICATED), object: nil)
    }
    
    func isFavorite(show: Show) -> Bool {
        let realm = try! Realm()
        let objects = realm.objects(ShowDB.self).filter("id = %@", show.id!)
        return objects.count > 0
    }
    
    func getAllFavorites() -> [Show] {
        let realm = try! Realm()
        let result = realm.objects(ShowDB.self)
        return Array(result).map { $0.toShow() }
    }
}
