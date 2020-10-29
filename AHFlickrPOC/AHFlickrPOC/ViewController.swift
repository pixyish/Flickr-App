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
    open var flickrReuseIdentifier = "flickrSearch"
    open var cellSize = 0
    var photos:Photos?
    let refreshControl = UIRefreshControl()
    var isCancelled = false
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUI()
    }
    
    
    override func viewDidLayoutSubviews() {
        cellSize = Int((flickrCollectionView.frame.size.width/2)-15)
    }
    
    @IBAction func cancelAll(_ sender: UIBarButtonItem) {
        isCancelled = true
    }
    
    //pull feature
    @objc private func refreshItemData(_ sender: Any) {
        // Fetch item Data by using pull to refresh
        self.callApi(path: URLs.getFlickrUrlUsingTitle())
        self.refreshControl.endRefreshing()
    }
    
    //MARK:- Private Methods
    func setUI() {
        self.registerXib()
        self.flickrCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshItemData(_:)), for: .valueChanged)
        self.callApi(path: URLs.getFlickrUrlUsingTitle())
    }
    
    func parseResponse(_ data: Data) -> FlickrSearchResult? {
        do {
            let decoder = JSONDecoder()
            let responseModel = try? decoder.decode(FlickrSearchResult.self, from: data)
            return responseModel
        } catch {
            print("Data parsing error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func callApi(path:String)  {
        photos = nil
        AHNetworkManager.sharedInstance.execute(requestMethod: .get, path: path, params: nil)  { [weak self] (apiStatus, response) in
            if apiStatus.isSuccess {
                if let model = self?.parseResponse(response as! Data) {
                       if let stat = model.stat, stat.uppercased().contains("OK") {
                            self?.photos = model.photos
                        
                            self?.flickrCollectionView.reloadData()
                       }
                   }
            } else {
                if let self = self {
                    self.showAlert(ttl: apiStatus.title, msg: apiStatus.msg)
                }
            }
        }
    }
    
    func registerXib()  {
        let collectionNib = UINib(nibName: "AHFlickrCollectionCell", bundle: nil)
        self.flickrCollectionView.register(collectionNib, forCellWithReuseIdentifier: flickrReuseIdentifier)
        self.flickrCollectionView.reloadData()
    }
}


