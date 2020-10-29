//
//  AHConstant.swift
//  AHFlickrPOC
//
//  Created by Piyush on 28/10/20.
//  Copyright © 2020 athenahealth. All rights reserved.
//

import UIKit

class AHConstant: NSObject {
    static let flickrUrl = "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=7b6f03d6c93c4ea5cf8549235edec0fa&per_page=20&page=1&format=json&nojsoncallback=1"
}

struct URLs {
    let flickrUrl = "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=7b6f03d6c93c4ea5cf8549235edec0fa&per_page=20&page=1&format=json&nojsoncallback=1"
    
    static func photoApiUrlString(photoIno:Photo) -> String {
        let imgUrlString = "https://live.staticflickr.com/\(photoIno.server ?? "")/\(photoIno.id ?? "")_\(photoIno.secret ?? "").jpg"
        return imgUrlString
    }
    
}
