//
//  TableViewController.swift
//  Pokedex
//
//  Created by Jeremy Warren on 9/5/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var pokemon: [Pokemon] = []
    var manager = PokemonManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.fetchPokemon()
}

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return pokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
        
        let pokemon = pokemon[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        return cell
    }
    
}

extension TableViewController: PokemonManagerDelegate {
    func didFetchPokemon(pokemon: [Pokemon]) {
        DispatchQueue.main.async {
            self.pokemon = pokemon
            self.tableView.reloadData()
        }
    }
    
    func didFail(error: Error?) {
        print(error as Any)
    }
    
    
}
