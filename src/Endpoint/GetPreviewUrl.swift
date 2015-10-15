//
//  GetPreviewUrl.swift
//  iTunesMusicKit
//
//  Created by 林達也 on 2015/10/16.
//  Copyright © 2015年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit

public struct GetPreviewUrl {
    
    public let id: String
    
    public let url: String

    public init(id: String, url: String) {
        self.id = id
        self.url = url
    }
}

extension GetPreviewUrl: iTunesRequestToken {
    
    public typealias Response = String
    public typealias SerializedObject = [String: AnyObject]
    
    public var method: HTTPMethod {
        return .GET
    }
    
    public var path: String {
        return url
    }
    
    public var headers: [String : String]? {
        return [
            "X-Apple-Store-Front": "143462-9,4",
        ]
    }
    
    public var serializer: Serializer {
        return .PropertyList(.Immutable)
    }
    
    
    public func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        print(object)
        
        let items = object["items"] as! [[String: AnyObject]]
        for item in items {
            let id = String(item["item-id"] as! Int)
            if self.id == id {
                let previewUrl = item["store-offers"]!["PLUS"]!!["preview-url"] as! String
                return previewUrl
            }
        }
        
        throw Error.Unknown
    }
}