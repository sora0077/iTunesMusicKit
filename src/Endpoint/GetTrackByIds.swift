//
//  GetTrackByIds.swift
//  iTunesMusicKit
//
//  Created by 林達也 on 2015/11/02.
//  Copyright © 2015年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit

public struct GetTrackByIds {
    
    public let ids: [String]
    
    let country: String
    
    public init(ids: [String], country: String) {
        self.ids = ids
        self.country = country
    }
}

extension GetTrackByIds: iTunesRequestToken {
    
    public typealias Response = [Track]
    public typealias SerializedObject = [String: AnyObject]
    
    public var method: HTTPMethod {
        return .GET
    }
    
    public var path: String {
        return "https://itunes.apple.com/lookup"
    }
    
    public var parameters: [String: AnyObject]? {
        return [
            "id": ids.joinWithSeparator(","),
            "country": country
        ]
    }
    
    public func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        let array = object["results"] as! [[String: AnyObject]]
        
        return array.map { dict in
            Track(
                id: String(dict["trackId"] as! Int),
                name: dict["trackName"] as! String,
                censoredName: dict["censoredName"] as? String,
                artistId: String(dict["artistId"] as! Int),
                albumId: String(dict["collectionId"] as! Int),
                album: nil,
                artist: nil,
                preview: nil,
                shortPreview: (
                    url: dict["previewUrl"] as! String,
                    duration: 30
                ),
                artwork: (
                    thumbnail: Album.Artwork(url: dict["artworkUrl100"] as! String, size: .Thumbnail),
                    large: Album.Artwork(url: dict["artworkUrl100"] as! String, size: .Large)
                ),
                url: dict["trackViewUrl"] as! String,
                price: String(dict["trackPrice"] as! Int),
                //            priceDisplay: dict[""] as! String,
                trackCount: dict["trackCount"] as? Int,
                trackNumber: dict["trackNumber"] as? Int,
                releaseDate: dict["releaseDate"] as! String
            )
        }
    }
}
