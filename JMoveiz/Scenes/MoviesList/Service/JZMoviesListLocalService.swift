//
//  JZMoviesListLocalService.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/31/23.
//

import Combine
import RealmSwift

final class JZMoviesListLocalService: JZMoviesListServiceProtocol {
    func getMovies(page: Int, query: String, genreIds: [Int]) -> AnyPublisher<JZPagedObject<JZMovie>, Error> {
        var results: RealmSwift.Results<JZMovie> = JZRealmManager.getObjects()
        if !query.isEmpty {
            results = results.filter("title CONTAINS %@", query)
        }
        return Just(.init(Array(results)))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
