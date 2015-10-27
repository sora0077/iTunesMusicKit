//
//  Album.swift
//  iTunesMusicKit
//
//  Created by 林達也 on 2015/10/14.
//  Copyright © 2015年 jp.sora0077. All rights reserved.
//

import Foundation

public struct Album {
    
    public var id: String
    
    public var name: String
    
    public var censoredName: String?
    
    public var artistId: String
    
    public var artist: Artist?
    
    public var url: String
    
    public var artwork: (
        thumbnail: Artwork,
        large: Artwork
    )
    
    
    public var discCount: Int
    
    public var discNumber: Int
    
    public var trackCount: Int
    
    public var price: String
    
    public var priceDisplay: String
    
    public var releaseDate: String
    
    public var copyright: String
    
    public struct Artwork {
        
        private static let regex = try! NSRegularExpression(pattern: "\\d{2,3}x\\d{2,3}", options: [])
        
        public enum Size {
            case Large
            case Thumbnail
            case Custom(width: Int, height: Int)
            
            var width: Int {
                switch self {
                case .Large:
                    return 600
                case .Thumbnail:
                    return 300
                case let .Custom(width: width, height: _):
                    return width
                }
            }
            var height: Int {
                switch self {
                case .Large:
                    return 600
                case .Thumbnail:
                    return 300
                case let .Custom(width: _, height: height):
                    return height
                }
            }
        }
        
        public var width: Int
        
        public var height: Int
        
        public var url: String
        
        init(url: String, size: Size) {
            
            let width = size.width
            let height = size.height
            let result = NSMutableString(string: url)
            
            Artwork.regex.replaceMatchesInString(result, options: [], range: NSMakeRange(0, url.characters.count), withTemplate: "\(width)x\(height)")
            
            self.url = result as String
            self.width = width
            self.height = height
        }
    }
}