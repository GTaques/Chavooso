//
//  ChavososViewController.swift
//  Chavooso
//
//  Created by Gabriel Taques on 04/05/19.
//  Copyright © 2019 Gabriel Taques. All rights reserved.
//

import UIKit

class ChavososViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var chavosoCollectionView: UICollectionView!
    
    var imagesArray: [String] = ["1","2", "3", "4", "5", "6", "7"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ChavosoSingleton.shared.likedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chavosoViewCell", for: indexPath) as! ChavosoItemCollectionViewCell
        cell.chavosoImage.image = UIImage(named: String(ChavosoSingleton.shared.likedList[indexPath.item]))
        cell.starIconView.image = UIImage(named: "Asset1")
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowOffset = .zero
        cell.layer.shadowRadius = 15
        cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.shouldRasterize = true
        //cell.layer.rasterizationScale = UIScreen.main.scale
        //cell.frame.width = collectionView.frame.width / 2
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 5, height: collectionView.frame.height / 3 - 10)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chavosoCollectionView.register(UINib(nibName: "ChavosoView", bundle: nil), forCellWithReuseIdentifier: "chavosoViewCell")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
