//
//  AHNetworkManager.swift
//  AHFlickrPOC
//
//  Created by Piyush on 28/10/20.
//  Copyright © 2020 athenahealth. All rights reserved.
//

import UIKit

enum ApiStatus:String {
    case success = ""
    case failed  = "Api failed"
    case invalidURL = "invalid Url"
    
    static func statusCode(code:Int) -> ApiStatus {
        switch code {
        case 200:
            return ApiStatus.success
        case 400:
            return ApiStatus.invalidURL
        default:
            return ApiStatus.failed
        }
    }
    var isSuccess:Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
    
    var title:String {
        return self.rawValue
    }
}

class AHNetworkManager: NSObject {
    static let sharedInstance = AHNetworkManager()
    
    
    func execute(requestMethod:RequestMethod,path:String,params:[String:Any]?,completion:@escaping(_ status:ApiStatus,_ response:Any?) -> Void) {
        
        guard let request = AHURLRequest(reqestMethod: requestMethod, urlString: path, params: params) else {
            DispatchQueue.main.async {
                completion(ApiStatus.invalidURL,nil)
            }
            return
        }
        
        let session = URLSession(configuration: .default)
        var apiStatus = ApiStatus.failed
        
        session.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                apiStatus = ApiStatus.statusCode(code: statusCode ?? 999)
                    completion(apiStatus, data)
            })
        }.resume()        
    }
}
