//
//  iTunesMusicKit.swift
//  iTunesMusicKit
//
//  Created by 林達也 on 2015/10/15.
//  Copyright © 2015年 jp.sora0077. All rights reserved.
//

import Foundation
import APIKit

public enum Error: APIKitErrorType {
    
    case APIError(ErrorType)
    case Unknown
    
    public static func networkError(error: ErrorType) -> Error {
        return .APIError(error)
    }
    
    public static func serializeError(error: ErrorType) -> Error {
        return .APIError(error)
    }
    
    public static func validationError(error: ErrorType) -> Error {
        return .APIError(error)
    }
    
    public static func unsupportedError(error: ErrorType) -> Error {
        return .APIError(error)
    }
}

public func iTunesMusicAPI() -> API<Error> {
    return API<Error>()
}


protocol iTunesRequestToken: RequestToken {
    
}
