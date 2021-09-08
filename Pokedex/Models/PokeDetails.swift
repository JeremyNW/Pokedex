//
//  PokeSprite.swift
//  Pokedex
//
//  Created by Jeremy Warren on 9/7/21.
//

import Foundation

struct PokeDetails : Codable {
    let abilities: [Ability]
    let sprites: SpriteSheet
    
}

struct SpriteSheet: Codable {
    let frontDefault: URL
}

struct Ability : Codable {
    let ability: AbilityMoves
}

struct AbilityMoves: Codable {
    let name : String
}
