//
//  MovieController.swift
//  StarWarsBiz
//
//  Created by Gavin Woffinden on 5/5/21.
//

import Foundation

class FilmsController {
    
    
    static func fetchMovie(completion: @escaping (Result <[StarWarsFilms], NetworkError>)-> Void) {
        let baseURL = URL(string: "https://swapi.dev/api/films/")
        
        guard let finalURL = baseURL else {return completion(.failure(.invalidURL))}
        
     URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let filmsTopLevelObject = try JSONDecoder().decode(FilmsTopLevelObject.self, from: data)
                let starWarsFilms = filmsTopLevelObject.results
                completion(.success(starWarsFilms))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    
    
    
    static func fetchMovieCharacters(characterURLString: String, completion: @escaping (Result<MovieCharacter, NetworkError>)-> Void) {
        guard let baseURL = URL(string: characterURLString) else {return completion(.failure(.invalidURL))}
              let finalURL = baseURL
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                
                let movieCharacter = try JSONDecoder().decode(MovieCharacter.self, from: data)
                completion(.success(movieCharacter))

                
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}

