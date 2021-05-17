//
//  CharacterListTableViewController.swift
//  StarWarsBiz
//
//  Created by Gavin Woffinden on 5/5/21.
//

import UIKit

class CharacterListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
    }
    
    
    //MARK: - Properties
    var movie: StarWarsFilms?
    var character: [String] = []
    
    
    //MARK: - Functions
    func fetchCharacters() {
        
        guard let movie = movie else {return}
        for character in movie.movieCharacters {
            
            FilmsController.fetchMovieCharacters(characterURLString: character) { result in
                DispatchQueue.main.async {
                    switch result {
                    
                    case .success(let character):
                        self.character.append(character.name)
                        self.tableView.reloadData()
                    case .failure(let error):
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        
        let characterName = character[indexPath.row]
        
        cell.textLabel?.text = characterName
        
        
        return cell
    }
    
    
    
    
    // MARK: - Navigation
    
    
    /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "toCharacterVC" {
     guard let indexPath = tableView.indexPathForSelectedRow,
     let movie = movie,
     let destinationVC = segue.destination as?
     }*/
    
    
}
