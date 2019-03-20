//
//  CardModel.swift
//  FunMatchGame
//
//  Created by George Vytka on 1/14/19.
//  Copyright © 2019 George Vytka. All rights reserved.
//

import Foundation


class CardModel{
    
    func getCards() -> [Card]{
       //store generated numbers
        var generatedNumbersArray = [Int]()
        
        
        //Declare an array to store the generated cards
        
        var generatedCardsArray = [Card]()
        
        //Randomly generate pairs of cards
        while generatedNumbersArray.count < 8 {
           //get random number
            let randomNumber = arc4random_uniform(13) + 1
            
            //maake sure the randon number is not there
            if generatedNumbersArray.contains(Int(randomNumber)) == false{
                //log the number
                
                //store number in array
                generatedNumbersArray.append(Int(randomNumber))
                // create the first card object
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardOne)
                
                //create the second card object
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCardsArray.append(cardTwo)
                // Make it si we only have unique pairs of cards
                
            }
            
            
        }
        // Randomize the array
        for i in 0...generatedCardsArray.count - 1{
        let randomNumber = Int(arc4random_uniform(UInt32(generatedNumbersArray.count)))
        
            let temporarystorage = generatedCardsArray[i]
            generatedCardsArray[i] = generatedCardsArray[randomNumber]
            generatedCardsArray[randomNumber] = temporarystorage
            
        //Randomize the array
        }
        return generatedCardsArray
    }
    
    
    
}
