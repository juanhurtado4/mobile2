//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true

struct Anime {
    let id: String
    let en: String
}

extension Anime : Decodable {
    // declaring our keys
    
    enum TopLevelKeys: String, CodingKey {
        case id
        case attributes
    }
    
    enum Attributes: String, CodingKey {
        case titles
//        case createdAt
//        case slug
//        case sypnosis
    }
    
    enum Titles: String, CodingKey {
        case en
    }
    
    init(from decoder: Decoder) throws {
        // Top level container
        let container = try decoder.container(keyedBy: TopLevelKeys.self)
        let id: String = try container.decode(String.self, forKey: .id)
        // Access nested container attributes
        let attributesContainer = try container.nestedContainer(keyedBy: Attributes.self, forKey: .attributes)
        // Access double nested container title
        let titles = try attributesContainer.nestedContainer(keyedBy: Titles.self, forKey: .titles)
        // Decoding from titles container
        let en = try titles.decodeIfPresent(String.self, forKey: .en)
        
        
        self.init(id: id, en: en)
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
                print("Anime id: \(anime.data)")
            }
    
            catch let jsonErr {
                print("error 2")
            }
            }.resume()
    }
}

let animeTest = ParseAnime(name: "Try")
animeTest


// Manual parsing JSON
//let json = JSONSerialization.data(withJSONObject: JSONSerialization, options: .dataFragments)
//
//let dictionary = json[[String]]
//let nestedContainer = dictionary[String: Any]
//let id = nestedContainer["id"] as! String
//let type = nestedContainer["type"] as! String
//let attributes = nestedContainer[String:Any]
//let creartedAt = attributes["createdAt"] as! String
//let slug = attributes["slug"] as! String
//let coverImageTopOFFset = attributes["coverImageTopOffSer"] as! Int

