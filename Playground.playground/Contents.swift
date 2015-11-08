//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
@testable import iTunesMusicKit

let api = iTunesMusicAPI()

api.request(ListGenres())
    .flatMap { v in
        api.request(ListTopSongsByGenre(genre: v.genre["29"]!))
    }
    .map { v -> ListTopSongsByGenre.Response in
        print(v.count)
        return v
    }
    .flatMap { v in
        api.request(GetPreviewUrl(id: v[1].id, url: v[1].url))
    }
    .map { v in
        print(v)
    }

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


