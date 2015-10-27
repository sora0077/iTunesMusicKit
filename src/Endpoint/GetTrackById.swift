//
//  GetTrackById.swift
//  iTunesMusicKit
//
//  Created by 林達也 on 2015/10/16.
//  Copyright © 2015年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit

public struct GetTrackById {
    
    public let id: String
    
    let country: String
    
    public init(id: String, country: String) {
        self.id = id
        self.country = country
    }
}

extension GetTrackById: iTunesRequestToken {
    
    public typealias Response = Track
    public typealias SerializedObject = [String: AnyObject]
    
    public var method: HTTPMethod {
        return .GET
    }
    
    public var path: String {
        return "https://itunes.apple.com/lookup"
    }
    
    public var parameters: [String: AnyObject]? {
        return [
            "id": id,
            "country": country
        ]
    }
    
    public func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        print(object)
        
        let dict = object["results"]![0] as! [String: AnyObject]
        
        return Track(
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
