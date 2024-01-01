//
//  RealmExtensions.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/30/23.
//

import RealmSwift

extension Object {
    func store() {
        let realm = try! Realm()
        try? realm.write {
            realm.add(self, update: .modified)
        }
    }
}

extension Sequence where Element == Object {
    func store() {
        forEach{ $0.store() }
    }
}

extension List where Element: Decodable {
    public convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.singleValueContainer()
        let decodedElements = try container.decode([Element].self)
        self.append(objectsIn: decodedElements)
    }
}

extension List where Element: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.map { $0 })
    }
}
