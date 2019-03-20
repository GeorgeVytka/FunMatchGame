//
//  ThirdViewController.swift
//  FunMatchGame
//
//  Created by George Vytka on 1/18/19.
//  Copyright © 2019 George Vytka. All rights reserved.
//

import UIKit
import Social


class ThirdViewController: UIViewController {

    var winStat = false
    var scoreData: String!
    
    let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainID") as UIViewController
    
    @IBOutlet weak var winStatusOutlet: UILabel!
    @IBOutlet weak var winImage: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var resetButtonOutlet: UIButton!
    @IBOutlet weak var clearScoreLabel: UIButton!
    
    
    @IBOutlet weak var shareTwitterOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = scoreData
        winStat = winStatus
       changeWinStatus()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // Mark: IBAction
    
    
    
    @IBAction func clearScoreButton(_ sender: Any) {
       
        let save = 0
        let userDefaults = Foundation.UserDefaults.standard
        userDefaults.set(save, forKey: "Record")
        
        scoreLabel.text = String(save)
        
        
        
        
    }
    
    
    //reset the other viewcontrollers to reset the game
    @IBAction func resetButton(_ sender: Any) {
       
        self.dismiss(animated: false, completion: nil)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
        
    }
    
    
    //when pressed the users sends the highscore to twitter
    @IBAction func shareTwitterButton(_ sender: Any) {
       
        let activityController = UIActivityViewController(activityItems: [scoreData], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
        
        
    }
    
    
    
    //Mark: functions
    //changes the label text to the win status
    func changeWinStatus(){
        print("win sta",winStat)
        if winStat == true{
            winImage.image = #imageLiteral(resourceName: "winningLabel")
            //winStatusOutlet.text = "Winner"
        }else{
            winImage.image = #imageLiteral(resourceName: "loserLabel")
            //winStatusOutlet.text = "Loser"
        }
    }
    
    
    
}
