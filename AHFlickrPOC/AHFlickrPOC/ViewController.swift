//
//  ViewController.swift
//  AHFlickrPOC
//
//  Created by Piyush on 28/10/20.
//  Copyright © 2020 athenahealth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var flickrCollectionView: UICollectionView!
    
    private var flickrReuseIdentifier = "flickrSearch"
    private var cellSize = 0
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUI()
    }
    
    override func viewDidLayoutSubviews() {
        cellSize = Int((flickrCollectionView.frame.size.width/2)-15)
    }
    
    //MARK:- Private Method
    func setUI() {
        self.registerXib()
    }
    
    func registerXib()  {
        
        let collectionNib = UINib(nibName: "AHFlickrCollectionCell", bundle: nil)
        self.flickrCollectionView.register(collectionNib, forCellWithReuseIdentifier: flickrReuseIdentifier)
        self.flickrCollectionView.reloadData()
    }
}


//MARK: - UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension ViewController:UICollectionViewDataSource {
    //1
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let flickrCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: flickrReuseIdentifier, for: indexPath) as! AHFlickrCollectionCell
        return flickrCollectionCell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(collectionView.frame.size.width)
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
