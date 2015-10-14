//
//  Track.swift
//  iTunesMusicKit
//
//  Created by 林達也 on 2015/10/14.
//  Copyright © 2015年 jp.sora0077. All rights reserved.
//

import Foundation

public struct Track {
    
    public var id: String
    
    public var name: String
    
    public var censoredName: String?
    
    public var artistId: String
    
    public var albumId: String
    
    public var album: Album?
    
    public var artist: Artist?
    
    public var preview: (
        url: String,
        duration: Int
    )?
    public var shortPreview: (
        url: String,
        duration: Int
    )?
    
    public var url: String
    
    public var price: String
    
    public var priceDisplay: String
    
    public var trackNumber: Int
    
    public var releaseDate: String
    
    public var copyright: String
}