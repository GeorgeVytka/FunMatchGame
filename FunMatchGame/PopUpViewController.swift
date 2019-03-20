//
//  PopUpViewController.swift
//  FunMatchGame
//
//  Created by George Vytka on 1/19/19.
//  Copyright © 2019 George Vytka. All rights reserved.
//

import UIKit

var timerObjPop = TimerClass()

class PopUpViewController: UIViewController {

    var viewControoler: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewDidDisappear(_ animated: Bool) {
        print("pop ended")
        _ = timeObj2.startTimer()
        
        
      
    }
    @IBAction func closePop(_ sender: Any) {
        self.view.removeFromSuperview()
        
    }
    @IBAction func toMenu(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        self.presentingViewController?.dismiss(animated: false, completion: nil)
    }
}
