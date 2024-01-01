//
//  JZMoviesListAPIService.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/31/23.
//

import Combine

final class JZMoviesListAPIService: JZMoviesListServiceProtocol {
    func getMovies(page: Int, query: String, genreIds: [Int]) -> AnyPublisher<JZPagedObject<JZMovie>, Error> {
        return JZMovieAPIs.getMovies(page: page, query: query, genreIds: genreIds)
            .store()
            .eraseToAnyPublisher()
    }
}
