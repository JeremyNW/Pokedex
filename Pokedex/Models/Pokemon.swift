

import Foundation

struct PokemonResponse: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
    let url: URL
    
}
