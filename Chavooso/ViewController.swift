//
//  ViewController.swift
//  Chavooso
//
//  Created by Gabriel Taques on 02/05/19.
//  Copyright © 2019 Gabriel Taques. All rights reserved.
//

import UIKit

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
    
    let imagesArray: [String] = ["01","02", "03", "04", "05", "06", "07"]
    var divisionParam: CGFloat!
    var firstImageIndex: Int! = 0
    var secondImageIndex: Int! = 1

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        backgroundImage.layer.zPosition = Layers.background
        firstCardView.layer.zPosition = Layers.firstCard
        secondCardView.layer.zPosition = Layers.secondCard
        likeImage.layer.zPosition = Layers.popImage
        dislikeImage.layer.zPosition = Layers.popImage
        
        firstCardImageView.image = UIImage(named: imagesArray[firstImageIndex])
        
        firstCardView.layer.cornerRadius = 15
        firstCardView.layer.masksToBounds = false
        firstCardView.layer.shadowColor = UIColor.darkGray.cgColor
        firstCardView.layer.shadowOpacity = 0.4
        firstCardView.layer.shadowOffset = CGSize(width: 4, height: 4)
        firstCardView.layer.shadowRadius = 4
        firstCardView.layer.shadowPath = UIBezierPath(rect: firstCardView.bounds).cgPath
        firstCardView.layer.shouldRasterize = true
        firstCardView.layer.rasterizationScale = UIScreen.main.scale
        
        secondCardImageView.image = UIImage(named: imagesArray[secondImageIndex])
        
        //secondCardView.layer.zPosition = 4
        secondCardView.layer.cornerRadius = 15
        secondCardView.layer.masksToBounds = false
        secondCardView.layer.shadowColor = UIColor.darkGray.cgColor
        secondCardView.layer.shadowOpacity = 0.4
        secondCardView.layer.shadowOffset = CGSize(width: 4, height: 4)
        secondCardView.layer.shadowRadius = 4
        secondCardView.layer.shadowPath = UIBezierPath(rect: secondCardView.bounds).cgPath
        secondCardView.layer.shouldRasterize = true
        secondCardView.layer.rasterizationScale = UIScreen.main.scale
        
        divisionParam = (view.frame.size.width/2)/0.70
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
                    self.resetCardPosition()
                })
                return
            }
            else if (cardView.center.x > (view.frame.size.width-20)) { // Moved to right
                secondCardView.alpha = 1
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x+400, y: cardView.center.y)
                })
                resetCardPosition()
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
        }, completion: { _ in
            self.resetCardPosition()
        })
    }
    
    func resetCardPosition() {
        if secondImageIndex < 7 {
            firstCardView.transform = .identity
            firstCardView.alpha = 1
            firstImageIndex += 1
            secondImageIndex += 1
            firstCardImageView.image = UIImage(named: imagesArray[firstImageIndex])
            secondCardImageView.image = UIImage(named: imagesArray[secondImageIndex])
            likeImage.alpha = 0
            dislikeImage.alpha = 0
            firstCardView.center = self.view.center
            secondCardView.alpha = 0.6

        }
    }
}

