//
//  ViewController.swift
//  Pokedex
//
//  Created by Jeremy Warren on 9/7/21.
//

import UIKit

class DetailViewController: UIViewController {

    var pokemon: Pokemon?
    
    var manager = PokeDetailsManager()
    
    @IBOutlet weak var pokeImageOutlet: UIImageView!
    @IBOutlet weak var pokeLabelOutlet: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.delegate = self
        manager.fetchDetailsForPokemon(pokemon: pokemon!)
        
        pokeLabelOutlet.text = pokemon?.name
        
        
    }
    
}


extension DetailViewController: PokeDetailsManagerDelegate {
    func didFetchDetails(pokemon: PokeDetails) {
        DispatchQueue.main.async {
            self.manager.fetchSpriteForPokemon(pokeDetails: pokemon)
        }
    }
    
    func didFetchSprite(pokemon: UIImage) {
        DispatchQueue.main.async {
            self.pokeImageOutlet.image = pokemon
        }
    }
    
    func didFail(error: Error?) {
        
    }
    
    
}

