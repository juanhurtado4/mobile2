//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true


struct Joke {
    let jokeType: String
    let setup: String
    let punchline: String
}

extension Joke: Decodable {

 enum Keys: String, CodingKey {
     case jokeType = "type"
     case setup
     case punchline
 }
 
 init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: Keys.self)
 
     let jokeType: String = try container.decode(String.self, forKey: .jokeType) // extracting the data
     let setup: String = try container.decode(String.self, forKey: .setup)
     let punchline: String = try container.decode(String.self, forKey: .punchline)
 
     self.init(jokeType: jokeType, setup: setup, punchline: punchline)
 }
}


class Parse {
    
    init(name: String) {
        let jsonURLString = "https://08ad1pao69.execute-api.us-east-1.amazonaws.com/dev/random_joke"
        guard let url = URL(string: jsonURLString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            
            do {
                let joke = try JSONDecoder().decode(Joke.self, from: data)
                print("Type of joke: \(joke.jokeType)\n")
                print("\(joke.setup)\n")
                print("\(joke.punchline)")
            }
                
            catch let jsonErr {
                print("error serializing json:", jsonErr)
            }
            }.resume()
    }
}

let attempt = Parse(name: "Joke Api")
attempt
