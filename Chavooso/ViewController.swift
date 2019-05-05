//
//  ViewController.swift
//  Chavooso
//
//  Created by Gabriel Taques on 02/05/19.
//  Copyright © 2019 Gabriel Taques. All rights reserved.
//

import UIKit

@IBDesignable
class ViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var secondCardView: UIView!
    @IBOutlet weak var secondCardImageView: UIImageView!
    
    @IBOutlet weak var firstCardView: UIView!
    @IBOutlet weak var firstCardImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var dislikeImage: UIImageView!
    
    let imagesArray: [String] = ["1","2", "3", "4", "5", "6", "7"]
    var divisionParam: CGFloat!
    var firstImageIndex: Int! = 0
    var secondImageIndex: Int! = 1

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        firstCardImageView.image = UIImage(named: imagesArray[firstImageIndex])
        
        firstCardView.layer.cornerRadius = 15
        firstCardView.layer.masksToBounds = false
        firstCardView.layer.shadowColor = UIColor.darkGray.cgColor
        firstCardView.layer.shadowOpacity = 0.4
        firstCardView.layer.shadowOffset = .zero
        firstCardView.layer.shadowRadius = 15
        firstCardView.layer.shadowPath = UIBezierPath(rect: firstCardView.bounds).cgPath
        firstCardView.layer.shouldRasterize = true
        firstCardView.layer.rasterizationScale = UIScreen.main.scale
        
        secondCardImageView.image = UIImage(named: imagesArray[secondImageIndex])
        
        secondCardView.layer.cornerRadius = 15
        secondCardView.layer.masksToBounds = false
        secondCardView.layer.shadowColor = UIColor.darkGray.cgColor
        secondCardView.layer.shadowOpacity = 0.4
        secondCardView.layer.shadowOffset = .zero
        secondCardView.layer.shadowRadius = 15
        secondCardView.layer.shadowPath = UIBezierPath(rect: secondCardView.bounds).cgPath
        secondCardView.layer.shouldRasterize = true
        secondCardView.layer.rasterizationScale = UIScreen.main.scale
        
        divisionParam = (view.frame.size.width/2)/0.2
    }
    
    @IBAction func swipeFrontCard(_ sender: UIPanGestureRecognizer) {
        let cardView = sender.view!
        let translationPoint = sender.translation(in: view)
        cardView.center = CGPoint(x: view.center.x+translationPoint.x, y: view.center.y+translationPoint.y)
        let distanceMoved = cardView.center.x - view.center.x
        secondCardView.alpha = 0
        if distanceMoved > 0 { // moved right side
            secondCardView.alpha = abs(distanceMoved)/view.center.x
            dislikeImage.alpha = abs(distanceMoved)/view.center.x
            likeImage.alpha = 0
        }
        else { // moved left side
            secondCardView.alpha = abs(distanceMoved)/view.center.x
            likeImage.alpha = abs(distanceMoved)/view.center.x
            dislikeImage.alpha = 0
        }
        cardView.transform = CGAffineTransform(rotationAngle: distanceMoved/divisionParam)
        secondCardView.alpha = abs(distanceMoved)/view.center.x
        
        if sender.state == UIGestureRecognizer.State.ended {
            if cardView.center.x < 20 { // Moved to left
                secondCardView.alpha = 1
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x-400, y: cardView.center.y)
                    
                }, completion: { _ in
                    ChavosoSingleton.shared.likedList.append(String(self.firstImageIndex + 1))
                    self.resetCardPosition()
                })
                return
            }
            else if (cardView.center.x > (view.frame.size.width-20)) { // Moved to right
                secondCardView.alpha = 1
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x+400, y: cardView.center.y)
                }, completion: { _ in
                    self.resetCardPosition()
                })
                return
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                cardView.center = self.view.center
                self.dislikeImage.alpha = 0
                self.likeImage.alpha = 0
                cardView.transform = .identity
            })
            
            
        }
    }
    
    @IBAction func likeTouched(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.firstCardView.center = CGPoint(x: self.firstCardView.center.x-400, y: self.firstCardView.center.y)
            self.firstCardView.transform = CGAffineTransform(rotationAngle: -0.2)
        }, completion: { _ in
            ChavosoSingleton.shared.likedList.append(String(self.firstImageIndex + 1))
            print(ChavosoSingleton.shared.likedList)
            self.resetCardPosition()
        })

    }
    @IBAction func dislikeTouched(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.firstCardView.center = CGPoint(x: self.firstCardView.center.x+400, y: self.firstCardView.center.y)
            self.firstCardView.transform = CGAffineTransform(rotationAngle: 0.2)
        }, completion: { _ in
            print(ChavosoSingleton.shared.likedList)
            self.resetCardPosition()
        })
    }
    
    func resetCardPosition() {
        if secondImageIndex >= 6 && firstImageIndex == 5{
            firstImageIndex = 6
            secondImageIndex = 0
        } else if firstImageIndex >= 6 && secondImageIndex == 0 {
            secondImageIndex += 1
            firstImageIndex = 0
        }
        else {
            firstImageIndex += 1
            secondImageIndex += 1
        }
        firstCardView.transform = .identity
        firstCardImageView.image = UIImage(named: imagesArray[firstImageIndex])
        secondCardImageView.image = UIImage(named: imagesArray[secondImageIndex])
        likeImage.alpha = 0
        dislikeImage.alpha = 0
        //firstCardView.center = self.view.center
        secondCardView.alpha = 0.4
    }
}

