//
//  JZMovieAPIs.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/30/23.
//

import ESNetworkManager
import Alamofire
import Combine

final class JZMovieAPIs {
    
    private init() {}
    
    static func getMovies(page: Int, query: String, genreIds: [Int]) -> AnyPublisher<JZPagedObject<JZMovie>, Error> {
        let path = query.isEmpty ? "discover" : "search"
        let request = ESNetworkRequest(path: "\(path)/movie")
        request.parameters?["include_adult"] = false
        request.parameters?["page"] = page
        request.parameters?["query"] = query
        request.encoding = URLEncoding.default
        return JZNetworkManager.execute(request: request)
    }
}
