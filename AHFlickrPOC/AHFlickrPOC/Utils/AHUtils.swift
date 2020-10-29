//
//  AHUtils.swift
//  AHFlickrPOC
//
//  Created by Piyush on 28/10/20.
//  Copyright © 2020 athenahealth. All rights reserved.
//

import UIKit

class AHUtils: NSObject {
    
    class func showAlert(ttl:String,msg:String,vc:UIViewController) {
        let alert = UIAlertController(title: ttl, message: msg, preferredStyle: .alert)
        vc.present(alert, animated: true, completion: nil)
    }
}
