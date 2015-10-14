//
//  Genre.swift
//  iTunesMusicKit
//
//  Created by 林達也 on 2015/10/14.
//  Copyright © 2015年 jp.sora0077. All rights reserved.
//

import Foundation

public struct Genres {

    public var id: String
    
    public var name: String
    
    public var topAlbums: String
    
    public var topSongs: String
    
    public var genre: [String: Genre]
    
    public struct Genre {
        
        public var id: String
        
        public var name: String
        
        public var topAlbums: String
        
        public var topSongs: String
        
        public var subgenre: [String: Subgenre]
        
        public struct Subgenre {
            
            public var id: String
            
            public var name: String
            
            public var topAlbums: String
            
            public var topSongs: String
        }
    }
    
}
