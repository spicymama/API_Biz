//
//  Movie.swift
//  StarWarsBiz
//
//  Created by Gavin Woffinden on 5/5/21.
//

import Foundation

struct FilmsTopLevelObject: Codable {
    let results: [StarWarsFilms]
}

struct StarWarsFilms: Codable {
    let title: String
    let releaseDate: String
    let movieCharacters: [String]
    
    enum CodingKeys: String, CodingKey {
        
        case title = "title"
        case releaseDate = "release_date"
        case movieCharacters = "characters"
    }
}
struct MovieCharacter: Codable {
    let name: String
    
}

