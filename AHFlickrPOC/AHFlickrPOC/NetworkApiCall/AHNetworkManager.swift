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
    case noInternet = "The Internet connection appears to be offline"
    
    static func statusCode(code:Int) -> ApiStatus {
        switch code {
        case 200:
            return ApiStatus.success
        case 400:
            return ApiStatus.invalidURL
        case 1019:
            return ApiStatus.noInternet
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
    var msg:String {
        switch self {
        case .noInternet:
            return AHConstant.internetOfflineMsg
        default:
            return ""
        }
    }
}

class AHNetworkManager: NSObject {
    static let sharedInstance = AHNetworkManager()
    
//    let session = URLSession(configuration: .default)
    func execute(requestMethod:RequestMethod,path:String,params:[String:Any]?,completion:@escaping(_ status:ApiStatus,_ response:Any?) -> Void) {
        
        guard let request = AHURLRequest(reqestMethod: requestMethod, urlString: path, params: params) else {
            DispatchQueue.main.async {
                completion(ApiStatus.invalidURL,nil)
            }
            return
        }
        
        let session = URLSession(configuration: .default)
        var apiStatus = ApiStatus.failed
        
        let status = Reach().connectionStatus()
        switch status {
        case .unknown,.offline:
            apiStatus = .noInternet
            break;
            default:
              break;
        }
        if apiStatus == .noInternet {
            completion(.noInternet,nil)
            return
        }
        
        session.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                
                apiStatus = ApiStatus.statusCode(code: statusCode ?? 999)
                    completion(apiStatus, data)
            })
        }.resume()        
    }
    
    func getImage(path:String,completion:@escaping(_ img:UIImage?) -> Void) -> Void {
        let session = URLSession(configuration: .default)
        var apiStatus = ApiStatus.failed
        
        guard let request = AHURLRequest(reqestMethod: .get, urlString: path, params: nil) else {
                   DispatchQueue.main.async {
                       completion(nil)
                   }
                   return
               }
        
        session.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                apiStatus = ApiStatus.statusCode(code: statusCode ?? 999)
                if apiStatus.isSuccess,let imgData = data, let img = UIImage(data: imgData) {
                    completion(img)
                } else {
                    completion(nil)
                }
            })
        }.resume()
    }
}
