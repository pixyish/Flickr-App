//
//  AHImageDownloader.swift
//  AHFlickrPOC
//
//  Created by Piyush on 29/10/20.
//  Copyright © 2020 athenahealth. All rights reserved.
//

import UIKit

extension UIImageView {
    
    //DOWNLOAD Image ASINC

    public func setImg(url: String){
        self.image = UIImage(named: "")
        AHNetworkManager.sharedInstance.getImage(path: url) { (img) in
            if let img = img {
                DispatchQueue.main.async {
                    self.image = img
                }
            }
        }
    }
}
    
