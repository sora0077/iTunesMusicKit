//
//  ListGenres.swift
//  iTunesMusicKit
//
//  Created by 林達也 on 2015/10/14.
//  Copyright © 2015年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit


public struct ListGenres {

    public var country: String
    
    var id: String
    
    public init(country: String = "jp") {
        self.country = country
        self.id = "34"
    }
}

extension Dictionary {
    
    func map<T, U>(@noescape transform: (Dictionary.Generator.Element) throws -> (T, U)) rethrows -> [T: U] {
        
        var projection: [T: U] = [:]
        for val in self {
            let (k, v) = try transform(val)
            projection[k] = v
        }
        return projection
    }
}

extension ListGenres: RequestToken {
    
    public typealias Response = Genres
    public typealias SerializedObject = [String: AnyObject]

    public var method: HTTPMethod {
        return .GET
    }
    
    public var path: String {
        return "https://itunes.apple.com/WebObjects/MZStoreServices.woa/ws/genres"
    }
    
    public var parameters: [String: AnyObject]? {
        return [
            "cc": country,
            "id": id
        ]
    }
    
    public func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        let dict = object[id] as! SerializedObject
        
        return Genres(
            id: dict["id"] as! String,
            name: dict["name"] as! String,
            topAlbums: dict["rssUrls"]!["topAlbums"] as! String,
            topSongs: dict["rssUrls"]!["topSongs"] as! String,
            genre: (dict["subgenres"] as! [String: SerializedObject]).map { k, dict in
                (k, Genres.Genre(
                    id: dict["id"] as! String,
                    name: dict["name"] as! String,
                    topAlbums: dict["rssUrls"]!["topAlbums"] as! String,
                    topSongs: dict["rssUrls"]!["topSongs"] as! String,
                    subgenre: (dict["subgenres"] as? [String: SerializedObject])?.map { k, dict in
                        (k, Genres.Genre.Subgenre(
                            id: dict["id"] as! String,
                            name: dict["name"] as! String,
                            topAlbums: dict["rssUrls"]!["topAlbums"] as! String,
                            topSongs: dict["rssUrls"]!["topSongs"] as! String
                        ))
                    } ?? [:]
                ))
            }
        )
    }
}