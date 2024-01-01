//
//  JZPagedObject.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/30/23.
//

import Foundation

struct JZPagedObject<Element>: Codable where Element: Codable {
    
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [Element]
    
    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension JZPagedObject {
    init(_ elements: [Element]) {
        self.results = elements
        self.page = 1
        self.totalPages = 1
        self.totalResults = elements.count
    }
}
