//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true

let url = URL(string: "https://08ad1pao69.execute-api.us-east-1.amazonaws.com/dev/random_ten")

var request = URLRequest(url: url!)
request.httpMethod = "GET"
//request.httpMethod = httpRequestStrings.GET

let session = URLSession.shared

let task = session.dataTask(with: request) { (data, response, error) in
    
    if let data = data {
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        print(json ?? "Did not work")
        
        
    }
    }.resume()


struct joke {
    let jokeType: String
    let setup: String
    let punchline: String
}

extension joke: Decodable {

 enum Keys: String, CodingKey {
     case jokeType
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






