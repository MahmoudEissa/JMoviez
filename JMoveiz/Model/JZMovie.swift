//
//  JZMovie.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/30/23.
//

import RealmSwift

class JZMovie: Object, Codable, Identifiable {
    
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var overview: String?
    @Persisted var posterPath: String?
    @Persisted var releaseDate: String?
    @Persisted var title: String?
    @Persisted var genreIDS: List<Int>

    enum CodingKeys: String, CodingKey {
        case genreIDS = "genre_ids"
        case id, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}

extension JZMovie {
    var thumbUrl: String {
        return NetworkConstants.thumbBaseUrl + (posterPath ?? "")
    }
    var imageUrl: String {
        return NetworkConstants.imageBaseUrl + (posterPath ?? "")
    }
    
    var year: String? {
        return releaseDate?.components(separatedBy: "-").first
    }
}
