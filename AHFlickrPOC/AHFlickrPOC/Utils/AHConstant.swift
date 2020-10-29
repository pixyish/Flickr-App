//
//  AHConstant.swift
//  AHFlickrPOC
//
//  Created by Piyush on 28/10/20.
//  Copyright © 2020 athenahealth. All rights reserved.
//

import UIKit

struct AHConstant {
    static let apiKey = "7b6f03d6c93c4ea5cf8549235edec0fa"
    static let totalSearchPerPage = "50"
    static let internetOfflineTitle = "The Internet connection appears to be offline"
    static let internetOfflineMsg = "please pull to refresh when you are connected to the internet"
    static let cacheImg = true
    static let placeHolderImg = "placeHolderImg"
}

struct URLs {
    
    static func photoApiUrlString(photoIno:Photo) -> String {
        let imgUrlString = "https://live.staticflickr.com/\(photoIno.server ?? "")/\(photoIno.id ?? "")_\(photoIno.secret ?? "").jpg"
        return imgUrlString
    }
    
    static func getFlickrUrlUsingTitle(ttl:String = "") -> String {
        if ttl.isEmpty {
            
            let flickrPhotoSearchUrl = "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(AHConstant.apiKey)&per_page=\(AHConstant.totalSearchPerPage)&page=1&format=json&nojsoncallback=1"
            return flickrPhotoSearchUrl
        } else {
            let searchStr = ttl.replacingOccurrences(of: " ", with: "%20")
            let flickrPhotoSearchUrl = "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(AHConstant.apiKey)&text=\(searchStr)&per_page=\(AHConstant.totalSearchPerPage)&page=1&format=json&nojsoncallback=1"
            return flickrPhotoSearchUrl
        }
    }
    
    
    
    
}
