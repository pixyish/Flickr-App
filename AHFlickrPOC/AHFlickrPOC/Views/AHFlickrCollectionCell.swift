//
//  AHSearchCell.swift
//  AHFlickrPOC
//
//  Created by Piyush on 28/10/20.
//  Copyright © 2020 athenahealth. All rights reserved.
//

import UIKit

class AHFlickrCollectionCell: UICollectionViewCell {
    @IBOutlet weak private var imgView:UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        imgView.image = nil
    }
    
    func show(info:Photo, isCancelled:Bool = false) {
        imgView.image = nil
        if isCancelled {
            if let img = self.imgView.cacheImg(imgName: "\(info.id ?? "").jpg") {
                self.imgView.image = img
            } else {
                self.imgView.image  = UIImage(named: AHConstant.placeHolderImg)
            }
        } else {
            activityIndicator.startAnimating()
            self.imgView.setImg(imgName: "\(info.id ?? "").jpg",  url: URLs.photoApiUrlString(photoIno:info)) { (isSuccess) in
                if !isSuccess {
                    self.imgView.image  = UIImage(named: AHConstant.placeHolderImg)
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
