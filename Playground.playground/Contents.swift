//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import APIKit
@testable import iTunesMusicKit

extension ListGenres: DebugRequestToken {}
extension GetPreviewUrl: DebugRequestToken {}
extension GetTrackById: DebugRequestToken {}
extension ListTopSongsByGenre: DebugRequestToken {}

let api = iTunesMusicAPI()

api.request(ListGenres())
    .flatMap { v in
        api.request(ListTopSongsByGenre(genre: v.genre["29"]!, limit: 3))
    }
    .map { v -> ListTopSongsByGenre.Response in
        print(v)
        return v
    }
    .flatMap { v in
        api.request(GetPreviewUrl(track: v[1]))
    }
    .map { v in
        print(v)
    }



XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


