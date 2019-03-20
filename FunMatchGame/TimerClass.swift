//
//  TimerClass.swift
//  FunMatchGame
//
//  Created by George Vytka on 1/20/19.
//  Copyright © 2019 George Vytka. All rights reserved.
//

import Foundation
import UIKit

protocol controlTime {
    func startTimer()
    func stopTimer()
}


class TimerClass: UIViewController {
    
    let vc =  UIStoryboard(name: "mainStory", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as UIViewController
    var milliseconds: Float = 10 * 1000
    var timer: Timer?
    var seconds = "0"
    var timerIsOn = false
    var cnt = 0
    func startTimer() -> String{
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerStart), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .common)
        cnt += 1
        print(seconds,"This the seconds in the startTimer")
        print(cnt, "also the cnt")
         return getSeconds()
    }
    
    
    @objc func timerStart() {
        milliseconds -= 1
        timerIsOn = true
        //convert to seconds
        
        
        //label
        setSeconds()
        
        
        
        
        //reaching zero
        
        if milliseconds <= 0{
            timer?.invalidate()
           // timerLabel.textColor = UIColor.red
            timerIsOn = false
           //TODO set checkGameEnded)_
            //checkGameEnded()
        }
       
    }
    
    func setSeconds(){
        seconds = String(format: "%.2f", milliseconds/1000)
    }
    
    func getSeconds() -> String{
        
        return "Time Remaining: \(seconds)"
    }
    
    func getmilliseconds() -> Float{
        
        return milliseconds
    }
    
    //checkes if milliseconds is zero
    func isMillZero() -> Bool{
        if milliseconds <= 0{
            return true
        }else{
            return false
        }
    }
    
    func TimeInvalidate(){
        timer?.invalidate()
    }
    
    //set the time status varble
    func setTimeStatus(_ timeStatus: Bool){
        timerIsOn = timeStatus
    }
    func getTimeStatus()->Bool{
        return timerIsOn
    }
    
}
