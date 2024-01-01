//
//  MoviesListService.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/30/23.
//

import Combine
import RealmSwift

protocol JZMoviesListServiceProtocol {
    func onStatusChanged(isConnected: Bool)
    func getMovies(page: Int, query: String, genreIds:  [Int]) -> AnyPublisher<JZPagedObject<JZMovie>, Error>
}

extension JZMoviesListServiceProtocol {
    func onStatusChanged(isConnected: Bool) { }
}


class JZMoviesListService: JZMoviesListServiceProtocol {
       
    private var decorator: JZMoviesListServiceProtocol = JZMoviesListAPIService()
    
    private func update(decorator: JZMoviesListServiceProtocol) {
        self.decorator = decorator
    }
    
    func onStatusChanged(isConnected: Bool) {
        decorator = isConnected ?  JZMoviesListAPIService() : JZMoviesListLocalService()
    }
    
    func getMovies(page: Int, query: String, genreIds: [Int]) -> AnyPublisher<JZPagedObject<JZMovie>, Error> {
        return decorator.getMovies(page: page, query: query, genreIds: genreIds)
    }
}
