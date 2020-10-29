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
    
    func show(info:Photo) {
        imgView.image = nil 
        activityIndicator.startAnimating()
        self.imgView.setImg(imgName: "\(info.id ?? "").jpg",  url: URLs.photoApiUrlString(photoIno:info)) { (isSuccess) in
            if isSuccess {
                self.activityIndicator.stopAnimating()
            }
        }
        
        
    }
}
