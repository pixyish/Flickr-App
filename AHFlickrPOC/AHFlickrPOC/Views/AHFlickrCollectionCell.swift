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
    @IBOutlet weak private var lbl:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        imgView.image = nil
    }
    
    func show(info:Photo) {
        self.imgView.setImg(url: URLs.photoApiUrlString(photoIno:info))
    }
}
