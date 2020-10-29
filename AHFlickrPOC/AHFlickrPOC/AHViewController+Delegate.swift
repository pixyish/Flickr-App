//
//  AHViewController+Delegate.swift
//  AHFlickrPOC
//
//  Created by Piyush on 29/10/20.
//  Copyright © 2020 athenahealth. All rights reserved.
//

import UIKit

//MARK: - UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension ViewController:UICollectionViewDataSource {
    //1
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos?.photo?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let flickrCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: flickrReuseIdentifier, for: indexPath) as! AHFlickrCollectionCell
        if let pictures = self.photos, let pic = pictures.photo?[indexPath.row] {
            flickrCollectionCell.show(info: pic)
        }
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

extension ViewController:UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let txt = searchBar.text ?? ""
        let path = URLs.getFlickrUrlUsingTitle(ttl: txt)
        self.callApi(path: path)
    }
}
