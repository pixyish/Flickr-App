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

    public func setImg(imgName:String,url: String,completion:@escaping(_ isScucess:Bool)-> Void){
        if AHConstant.cacheImg, let cacheImg = self.cacheImg(imgName: imgName) {
            self.image = cacheImg
            completion(true)
        } else {
            AHNetworkManager.sharedInstance.getImage(path: url) { (img) in
                if let img = img {
                    DispatchQueue.main.async {
                        self.image = img
                        if AHConstant.cacheImg {
                            let _ = self.cacheImg(imgName: imgName)
                        }
                        completion(true)
                    }
                } else {
                    completion(false)
                }
            }
        }
    }
    
    func cacheImg(imgName:String) -> UIImage?  {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(imgName)
    
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else if let img = self.image {
            // get your UIImage jpeg data representation and check if the destination file url already exists
            if let data = img.jpegData(compressionQuality:  0.5),
              !FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    // writes the image data to disk
                    try data.write(to: fileURL)
                    print("file saved")
                } catch {
                    print("error saving file:", error)
                }
            }
        }
        return nil
    }
    
    
}
  
extension UIViewController {
    func showAlert(ttl:String,msg:String) {
        let alert = UIAlertController(title: ttl, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
