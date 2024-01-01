//
//  JZRealmManager.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/30/23.
//

import RealmSwift

final class JZRealmManager {
    
    private init() {  }
    
    static func getObjects<T: Object>() -> RealmSwift.Results<T> {
        let realm = try! Realm()
        return realm.objects(T.self)
    }
    
    static func clear() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}
