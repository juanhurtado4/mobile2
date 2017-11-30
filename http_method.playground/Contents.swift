//: Playground - noun: a place where people can play

import UIKit


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Resource {
    
    case posts
    case comments
    
    func httpMethod() -> HTTPMethod {
        switch self {
        case .posts, .comments:
            return .get
        }
        
    }
    
    func header(token: String) -> [String: String] {
        switch self {
        case .posts, .comments:
            return ["Authorization": "Bearer 41e1fee034bc2b00fd3af6532e93d5b35f1e217e00173b67b761f94daff6e4e2"]
        }
    }
    
    func path() -> String {
        switch self {
        case .posts:
            return ""
        }
    }
}

/*
 
https://api.producthunt.com/v1/posts/all
Bearer 41e1fee034bc2b00fd3af6532e93d5b35f1e217e00173b67b761f94daff6e4e2
Authorization
 
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Resource {
    case posts
    case comments(postId: String)
    
    func httpMethod() -> HTTPMethod {
        switch self {
        case .posts, .comments:
            return .get
        }
    }
    
    func header(token: String) -> [String: String] {
        switch self {
        case .posts, .comments:
            return [
                "Authorization": "\(token)",
                "Content-Type": "application/json"
            ]
        }
    }
    
    func path() -> String {
        switch self {
        case .posts:
            return "/me/feed"
        case .comments:
            return "/comments"
        }
    }
    
    //6
    func urlParameters() -> [String: String] {
        switch self {
        case .comments(let postId):
            return ["search_id": postId]
        case .posts:
            return [:]
        }
    }
    
    func body() -> Data? {
        switch self {
        case .posts, .comments:
            return nil
        }
    }
}




class Networking {
    let session = URLSession.shared
    let baseUrl = "https://api.producthunt.com/v1"
    
    func fetch(resource: Resource, completion: @escaping () -> ()) {
        
        let fullUrl = baseUrl.appending(resource.path())
        
        let url = URL(string: fullUrl)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = resource.header(token: "token_value")
        request.httpMethod = resource.httpMethod().rawValue
        
        session.dataTask(with: request) { (data, res, err) in
            completion()
            }.resume()
        
    }
}
*/
