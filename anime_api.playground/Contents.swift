//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true

struct Anime {
    let id: String
}

extension Anime : Decodable {
    // declaring our keys
    
    enum TopLevelKeys: String, CodingKey {
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TopLevelKeys.self)
        
        let id: String = try container.decode(String.self, forKey: .id)
        
        self.init(id: id)
    }
}

struct AnimeArr: Decodable {
    let data: [Anime]
}

class ParseAnime {
    
    init(name: String) {
    let animeURL = "https://kitsu.io/api/edge/anime"
        guard let url = URL(string: animeURL) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, resposne, err) in
            
            guard let data = data else {return}
    
            do {
                let anime = try JSONDecoder().decode(AnimeArr.self, from: data)
                print("Anime id: \(anime.data[0])")
            }
    
            catch let jsonErr {
                print("error 2")
            }
            }.resume()
    }
}

let animeTest = ParseAnime(name: "Try")
animeTest
