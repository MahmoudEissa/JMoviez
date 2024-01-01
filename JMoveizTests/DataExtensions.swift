//
//  DataExtensions.swift
//  JMoveizTests
//
//  Created by Mahmoud Eissa on 12/31/23.
//

import Foundation

extension Data {
    init(file: String) {
        let bundle = Bundle.init(for: MockURLProtocol.self)
        let url = bundle.url(forResource: file, withExtension: "json")
        self = try! .init(contentsOf: url!)
    }
}
