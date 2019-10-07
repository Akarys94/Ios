//
//  AboutMe.swift
//  HomeWork3
//
//  Created by Aka on 23.09.19.
//  Copyright © 2019 Aka. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import AVFoundation


class AboutMe: UIViewController {
    let pianod = URL(fileURLWithPath: Bundle.main.path(forResource: "Epic", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let FirstEnter = !UserDefaults.standard.bool(forKey: "FirstStart")
        if FirstEnter {
            print("FirstStart!!!")
            UserDefaults.standard.set(true, forKey: "FirstStart")
        }
        KeychainWrapper.standard.set("Jumys",forKey: "password")
        let secretPassword = KeychainWrapper.standard.string(forKey: "password")
        print("password\(secretPassword)")
       

    }
    override func viewDidAppear(_ animated: Bool) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: pianod)
            audioPlayer.play()
        } catch {
            print("couldn't load file")
            // couldn't load file
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
         audioPlayer.pause()
    }
    
}
