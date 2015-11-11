//
//  ListTopSongsByGenre.swift
//  iTunesMusicKit
//
//  Created by 林達也 on 2015/10/20.
//  Copyright © 2015年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit

public struct ListTopSongsByGenre {
    
    let url: String
    
    init(var url: String, limit: Int = 100) {
        
        if url.containsString("limit") {
            let paths = url.componentsSeparatedByString("/")
            url = paths.map({ p in
                p.hasPrefix("limit") ? "limit=\(limit)" : p
            }).joinWithSeparator("/")
        } else {
            var paths = url.componentsSeparatedByString("/")
            paths.insert("limit=\(limit)", atIndex: paths.count - 1)
            url = paths.joinWithSeparator("/")
        }
        
        
        self.url = url
    }
}

public extension ListTopSongsByGenre {
    
    init(genre: Genres.Genre, limit: Int = 100) {
        self.init(url: genre.topSongs, limit: limit)
    }
}

private let regex = try! NSRegularExpression(pattern: "id(\\d+)", options: [])

extension ListTopSongsByGenre: iTunesRequestToken {
    
    public typealias Response = [Track]
    public typealias SerializedObject = [String: AnyObject]
    
    public var method: HTTPMethod {
        return .GET
    }
    
    public var path: String {
        return url
    }
    
    public func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        let entry = object["feed"]!["entry"] as! [[String: AnyObject]]
        
//        print(entry as NSArray)
        
        return entry.map { dict in
            Track(
                id: dict["id"]!["attributes"]!!["im:id"] as! String,
                name: dict["im:name"]!["label"] as! String,
                censoredName: dict["im:name"]!["label"] as? String,
                artistId: {
                    let string = dict["im:artist"]!["attributes"]!!["href"] as! String
                    let result = regex.firstMatchInString(string, options: [], range: NSMakeRange(0, string.characters.count))!
                    return (string as NSString).substringWithRange(result.rangeAtIndex(1))
                }(),
                albumId:  {
                    let string = dict["im:collection"]!["link"]!!["attributes"]!!["href"] as! String
                    let result = regex.firstMatchInString(string, options: [], range: NSMakeRange(0, string.characters.count))!
                    return (string as NSString).substringWithRange(result.rangeAtIndex(1))
                }(),
                album: nil,
                artist: nil,
                preview: nil,
                shortPreview: (
                    url: dict["link"]![0]!["attributes"]!!["href"] as! String,
                    duration: 30
                ),
                artwork: (
                    thumbnail: Album.Artwork(url: dict["im:image"]![0]["label"] as! String, size: .Thumbnail),
                    large: Album.Artwork(url: dict["im:image"]![0]["label"] as! String, size: .Large)
                ),
                url: dict["id"]!["label"] as! String,
                price: dict["im:price"]!["attributes"]!!["amount"] as! String,
                //            priceDisplay: dict[""] as! String,
                trackCount: nil,
                trackNumber: nil,
                releaseDate: dict["im:releaseDate"]!["label"] as! String
            )
        }
    }
}