//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import Foundation

PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true

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

struct AnimeList: Decodable {
    let data: [Anime]
}

typealias JSON = [String: Any]

class NetworkingTest {
    
    let animeURL = URL(string: "https://kitsu.io/api/edge/anime")
    
    URLSession.shared.dataTask(with: animeURL) { (data, response, err) in
    
        guard let data = data else {return}
    
        do {
            let anime = try JSONDecoder().decode(AnimeList.self, from: data)
            print("Title: \(anime.title)\n Rating: \(anime.rating)\n Synopsis: \(anime.synopsis)")
        }
    
        catch let jsonErr {
            print("error")
        }
    }.resume()
}

let animeTest = NetworkingTest()
animeTest

/*
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
*/


