//
//  CardCollectionViewCell.swift
//  FunMatchGame
//
//  Created by George Vytka on 1/14/19.
//  Copyright © 2019 George Vytka. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card: Card){
       //track the card passed in
        self.card = card
        
        if card.isMarched == true{
            backImageView.alpha = 0
            frontImageView.alpha = 0
            
            return
        }
        else{
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        frontImageView.image = UIImage(named: card.imageName)
        
        //Determine if the card is in a flipped up state or flipped down
        if card.isFlipped == true{
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }else{
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        }
        
    }
    func flip(){
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
             UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        
    }
    
    func remove(){
        //remouves
        backImageView.alpha = 0
        // ANIMAte
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
           self.frontImageView.alpha = 0
        }, completion: nil)
        
        
    }
}
