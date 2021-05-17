//
//  FilmListTableViewController.swift
//  StarWarsBiz
//
//  Created by Gavin Woffinden on 5/5/21.
//

import UIKit

class FilmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFilms()
    }

    var movies: [StarWarsFilms] = []
    
    
    func fetchFilms() {
        FilmsController.fetchMovie { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self.movies.append(contentsOf: movie)
                    self.tableView.reloadData()
                case .failure(let error):
                     print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath)
        cell.textLabel?.text = movies[indexPath.row].title
        cell.detailTextLabel?.text = movies[indexPath.row].releaseDate
        return cell
        
    }
    

    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCharacterVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? CharacterListTableViewController else {return}
                
            let selectedMovie = movies[indexPath.row]
            destinationVC.movie = selectedMovie
            }
        }
    
}
