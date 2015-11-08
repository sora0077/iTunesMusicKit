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
    
    public var id: String {
        return getTrackByIds.ids[0]
    }
    
    var country: String {
       return getTrackByIds.country
    }
    
    private let getTrackByIds: GetTrackByIds
    
    public init(id: String, country: String) {
        self.getTrackByIds = GetTrackByIds(ids: [id], country: country)
    }
}

extension GetTrackById: iTunesRequestToken {
    
    public typealias Response = Track
    public typealias SerializedObject = [String: AnyObject]
    
    public var method: HTTPMethod {
        return getTrackByIds.method
    }
    
    public var path: String {
        return getTrackByIds.path
    }
    
    public var parameters: [String: AnyObject]? {
        return getTrackByIds.parameters
    }
    
    public func transform(request: NSURLRequest?, response: NSHTTPURLResponse?, object: SerializedObject) throws -> Response {
        
        let res = try getTrackByIds.transform(request, response: response, object: object)
        if let item = res.first {
            return item
        }
        throw Error.serializeError(NSError(domain: "", code: 0, userInfo: nil))
    }
}
