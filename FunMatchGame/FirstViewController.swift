//
//  FirstViewController.swift
//  FunMatchGame
//
//  Created by George Vytka on 1/18/19.
//  Copyright © 2019 George Vytka. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var highScoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        
        if (value == nil){
            highScoreLabel.text = "0"
        }else{
            highScoreLabel.text = value
        }
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
