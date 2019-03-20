//
//  SoundsManger.swift
//  FunMatchGame
//
//  Created by George Vytka on 1/16/19.
//  Copyright © 2019 George Vytka. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManger{
    
   static  var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        case flip
        case shuffle
        case match
        case nomatch
        
    }
    static func playSound(_ effect: SoundEffect){
        var soundFilename = ""
        
        switch effect {
        case .flip:
            soundFilename = "cardflip"
            
        case .shuffle:
            soundFilename = "shuffle"
        case .match:
            soundFilename = "dingcorrect"
        case .nomatch:
            soundFilename = "dingwrong"
            
         
        }
        
        
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        guard bundlePath != nil else{
           print("no sound")
            return
        }
        
        //create url object
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        do{
        //audio player
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            audioPlayer?.play()
            
        }catch{
            print("cound't create audio object")
        }
    }
    
    
}
