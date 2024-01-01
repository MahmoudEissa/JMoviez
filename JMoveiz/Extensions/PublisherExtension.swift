//
//  PublisherExtension.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/30/23.
//

import RealmSwift
import Combine

extension Publisher where Output: Sequence, Output.Element == Object {
    func stored() -> Publishers.HandleEvents<Self> {
        return handleEvents(receiveOutput: { ($0 as? [Output.Element])?.store() })
    }
}
extension Publisher where  Output == JZPagedObject<JZMovie> {
    func store() -> Publishers.HandleEvents<Self> {
        return handleEvents(receiveOutput: { response in
            response.results.forEach { $0.store() }
        })
    }
}
