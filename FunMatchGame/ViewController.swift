//
//  ViewController.swift
//  FunMatchGame
//
//  Created by George Vytka on 1/13/19.
//  Copyright © 2019 George Vytka. All rights reserved.
//

import UIKit
var winStatus = false
var timerIsOn = false



class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBAction func testButton(_ sender: Any) {
        let vc = ThirdViewController()
        present(vc,animated: true, completion:  nil)
    }
    
    //objects
    var timer: Timer?
    var model = CardModel()
    var cardArray = [Card]()
    
    var tempTimer: Timer?
    var tempSeconds = "0"
    var timelabel = "0"
    var firstFlipCardIndex:IndexPath?
    var milliseconds: Float = 5 * 1000
    var seconds = "0"
    var gameScore = 0
    var gameHighScore: String!
    
    
   
    @IBOutlet weak var collectiobView: UICollectionView!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         cardArray = model.getCards()
       collectiobView.delegate = self
        collectiobView.dataSource = self
        
        //call the getVards method
      //start the timer
      
       
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerStart), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
        
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        gameHighScore = value
    }
    
    @objc func timerStart() {
        milliseconds -= 1
        timerIsOn = true
        //convert to seconds
        seconds = String(format: "%.2f", milliseconds/1000)
        
        //label
     timerLabel.text = String(seconds)
        
        
        
        
        //reaching zero
        
        if milliseconds <= 0{
            timer?.invalidate()
            // timerLabel.textColor = UIColor.red
            timerIsOn = false
            //TODO set checkGameEnded)_
            checkGameEnded()
        }
        
    }
    
    //TODO get rid of this shit
    
    
    
    
    //send win status to the third viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receiverVC = segue.destination as! ThirdViewController
       // receiverVC.winStat = winStatus
       receiverVC.winStat = winStatus
        //send the instance of the time object 
        
        
        
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        SoundManger.playSound(.shuffle)
        
    }
    //Mark: -Timer
    
    
    
    
    
    
    
    //MARK: - UIcollectionView Protocol Methods
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //get a CardCell view cell object
        let cell = collectiobView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
       //get the card the view is trying to display
        let card = cardArray[indexPath.row]
        cell.setCard(card)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //check time
        if milliseconds <= 0{
            
            end()
            return
        }
        
        
        
        //get the cell that the user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //get the card the user selected
        let card = cardArray[indexPath.row]
        
        
        if card.isFlipped == false && card.isMarched == false{
           
            //flip card
            cell.flip()
            
            // Pplay sound flip
            SoundManger.playSound(.flip)
            //set the status of the card
            card.isFlipped = true
            
            //Determine if its the first card or second card
            if firstFlipCardIndex == nil{
                //first
                firstFlipCardIndex = indexPath
            }else{
                //second
                
                //PErform matching logic
                checkForMatches(indexPath)
            }
        }
        
        
    }
    //MARK: - Game Logic Methods
    func checkForMatches(_ secondFlippedCardIndex: IndexPath){
        
        //Get the cells for the two cards
        let cardOneCell = collectiobView.cellForItem(at: firstFlipCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectiobView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        let cardOne = cardArray[firstFlipCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        
        //compare
       if cardOne.imageName == cardTwo.imageName {
            //Match
            SoundManger.playSound(.match)
            //set the status
        cardOne.isMarched = true
        cardTwo.isMarched = true
        
        cardOneCell?.remove()
        cardTwoCell?.remove()
        gameScore += 1
        print("game score before func", gameScore)
        //check if card left
        checkGameEnded()
        }else{
            //Its not a match
        SoundManger.playSound(.nomatch)
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
        
        cardOneCell?.flipBack()
        cardTwoCell?.flipBack()
        }
        //tell the collection to reload cell of the first card
        if cardOneCell == nil{
            collectiobView.reloadItems(at: [firstFlipCardIndex!])
        }
        
        // resest the property thst tracks themfirst card flipped
        firstFlipCardIndex = nil
    }
    
    func checkGameEnded(){
        //If there are any card unmatched
        print("begin of checj game")
        var isWon = true
        
        for card in cardArray{
            if card.isMarched == false{
                isWon = false
                break
            }
           
            
            
            
        }
        
        
        var title = ""
        var message = ""
        
        if isWon == true{
            if milliseconds > 0{
               timer?.invalidate()
                print("in the isWon")
            }
            title = "congratulation!"
            message = "You have won"
            
            winStatus = true
            calculateScore()
            highScore()
           //self.performSegue(withIdentifier: "segue", sender: nil)
            end()
            
        }
        else{
            if milliseconds > 0{
                return
            }
             print("in the else in check")
            title = "GameOver"
            message = "You loss"
            winStatus = false
            calculateScore()
            highScore()
            //self.performSegue(withIdentifier: "segue", sender: nil)
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ViewController.end), userInfo: nil, repeats: false)
            end()
        }
        
        showAlert(title, message)
    }
    
    
    func calculateScore(){
        if milliseconds > 0{
            gameScore = (Int(milliseconds) * gameScore) / 1000
            
        }
        print("game score",gameScore)
    }
    
    func showAlert(_ title:String, _ message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func end(){
        print("in end func1")
       //
      let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame") as! ThirdViewController
       vc.scoreData = String(gameScore)
        self.present(vc, animated: true, completion: nil)
        print("in end func1")
        
        
   }
    func highScore(){
        
        if gameHighScore == nil{
            let savedString = gameScore
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(savedString, forKey: "Record")
        }else {
            let score: Int? = gameScore
            let recond: Int? = Int(gameHighScore)
            
            if score! > recond!{
                let savedString = gameScore
                let userDefaults = Foundation.UserDefaults.standard
                userDefaults.set(savedString, forKey: "Record")
            }
            
        }
        
        
    }
}//end

