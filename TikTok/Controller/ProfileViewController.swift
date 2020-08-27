//
//  ProfileViewController.swift
//  TikTok
//
//  Created by Ganesh Bisht on 10/08/20.
//  Copyright © 2020 TikTok. All rights reserved.
//


import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageSet =  ["hulk-1","venom","toronto","spiderman","thanos","toronto","venom","hulk-1","war_machine"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView.reloadData()
    }
    


}




extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileItemCell", for: indexPath) as! ProfileItemCollectionViewCell
        cell.itemImageView.image = UIImage(named: imageSet[indexPath.row])
        return cell
    }
    
    
}
