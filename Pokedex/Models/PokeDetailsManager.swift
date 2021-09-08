//
//  PokeDetailsManager.swift
//  Pokedex
//
//  Created by Jeremy Warren on 9/7/21.
//

import Foundation
import UIKit

protocol PokeDetailsManagerDelegate {
    func didFetchDetails(pokemon: PokeDetails)
    func didFetchSprite(pokemon: UIImage)
    func didFail(error: Error?)
}


struct PokeDetailsManager {
    
    var delegate: PokeDetailsManagerDelegate?
    
    func fetchDetailsForPokemon(pokemon: Pokemon) {
        
        // BUILD URL
        let url = pokemon.url
        
        // Fetch data?
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                delegate?.didFail(error: error)
            return
            }
            
            guard let data = data else {
                delegate?.didFail(error: nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(PokeDetails.self, from: data)
                delegate?.didFetchDetails(pokemon: response)
            } catch {
                delegate?.didFail(error: error)
                return
            }
        }.resume()
        
        
    }
    
    
    func fetchSpriteForPokemon (pokeDetails: PokeDetails) {
        let url = pokeDetails.sprites.frontDefault
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                delegate?.didFail(error: error)
            return
            }
            
            guard let data = data else {
                delegate?.didFail(error: nil)
                return
            }
            guard let image = UIImage (data: data) else {
                delegate?.didFail(error: error)
                return
            }
            delegate?.didFetchSprite(pokemon: image)
            
        }.resume()
    }
    
}


