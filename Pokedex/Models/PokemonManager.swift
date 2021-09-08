

import Foundation

protocol PokemonManagerDelegate {
    func didFetchPokemon(pokemon: [Pokemon])
    func didFail(error: Error?)
}

struct PokemonManager {
    
    var delegate: PokemonManagerDelegate?
    
    func fetchPokemon() {
        
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=151") else {
            delegate?.didFail(error: nil)
            return
        }
        
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
                let response = try decoder.decode(PokemonResponse.self, from: data)
                delegate?.didFetchPokemon(pokemon: response.results)
            } catch {
                delegate?.didFail(error: error)
                return
            }
        }.resume()
        
    }
    
}
