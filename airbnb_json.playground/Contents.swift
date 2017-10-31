//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import Foundation

PlaygroundSupport.

struct Anime {
    
    let title: String
    let synopsis: String
    let rating: String
}

extension Anime: Decodable {
    
    enum TopLevelKeys: String, CodingKey {
        case attributes
    }
    
    enum AttributesKeys: String, CodingKey {
        case synopsis
        case rating
        case titlekey
    }
    
    enum TitleKeys: String, CodingKey {
        case title = "en"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TopLevelKeys.self)
        
        let attributesContainer = try container.nestedContainer(keyedBy: AttributesKeys.self, forKey: .attributes)
        
        let titleContainer = try attributesContainer.nestedContainer(keyedBy: TitleKeys.self, forKey: .titlekey)
        
        let title = try titleContainer.decodeIfPresent(String.self, forKey: .title)
        
        let synopsis = try attributesContainer.decodeIfPresent(String.self, forKey: .synopsis)
        
        let rating = try attributesContainer.decodeIfPresent(String.self, forKey: .rating)
        
        self.init(title: title, synopsis: synopsis, rating: rating)
    }
}

struct AnimeList: Decoable {
    let data: [Anime]
}

typealias JSON = [String: Any]

class Networking {
    
    let animeURL = URL(string: "https://kitsu.io/api/edge/anime")
    
    URLSession.shared
}





