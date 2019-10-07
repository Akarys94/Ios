//
//  ConverterQuotes.swift
//  HomeWork3
//
//  Created by Aka on 17.09.19.
//  Copyright © 2019 Aka. All rights reserved.
//
import UIKit
import RealmSwift
import AVFoundation
//import AVKit


class ConverterQuotes: UIViewController {
    var currentNumbers:Double = 0;
    var quote: Quote?
    let pianoSound = URL(fileURLWithPath: Bundle.main.path(forResource: "click", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    static let NOTIFIC_SELECTED_QUOTE = "selectedQuote"
    static let BUTTON_TAG = "buttonTagSelectQuote"
    
    @IBOutlet weak var labelOfQuote: UILabel!
    @IBOutlet weak var labelOfConvert: UILabel!
    @IBOutlet weak var BaseQuote: UILabel!
    @IBOutlet weak var SecondaryQuote: UILabel!
    @IBOutlet weak var BaseSelectButton: UIButton!
    @IBOutlet weak var SecondarySelectButton: UIButton!
    @IBOutlet weak var baseImage: UIImageView!
    @IBOutlet weak var SecondaryImage: UIImageView!
    @IBOutlet weak var calcNumbers: UIStackView!
    
    
    var baseValue: String = ""
    var secondaryValue: String = ""
    
    
    
    
//    @IBAction func speak(_ sender: UIButton) {
//        let synthesizer = AVSpeechSynthesizer()
//        let utterance = AVSpeechUtterance(string: "Привет. Это пример.")
//        utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
//        synthesizer.speak(utterance)
//    }
    @IBAction func numbers(_ sender: UIButton)
    {
        if(labelOfQuote.text != nil){
            labelOfQuote.text = labelOfQuote.text! + String(sender.tag)
            currentNumbers = Double(labelOfQuote.text!)!
        }
        if(labelOfQuote.text == "0"){
            labelOfQuote.text = ""
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: pianoSound)
            audioPlayer.play()
        } catch {
            // couldn't load file
        }
        convert()
    }
    func convert(){
        var currentnumbers = (labelOfQuote.text as! NSString).doubleValue
        var basenumber = (baseValue as! NSString).doubleValue
        var secondarynumber = (secondaryValue as! NSString).doubleValue
        var finalQuote = currentnumbers * secondarynumber / basenumber
        labelOfConvert.text = String(finalQuote)
    }
    @IBAction func clearNumbers(_ sender: UIButton)
    {
        labelOfQuote.text = ""
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration:0.4 ){
            self.calcNumbers.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        
        let buttonArray = [BaseSelectButton,SecondarySelectButton]
        for (index, button) in buttonArray.enumerated(){
            let delay = Double(index) * 0.3
            UIView.animate(withDuration: 0.6, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                button?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        calcNumbers.transform = CGAffineTransform(scaleX: 0, y: 0)
        BaseSelectButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        SecondarySelectButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(selectQuote), name: NSNotification.Name("selectedQuote"), object: nil)
    }
    
    
    
    @objc func selectQuote(notif:Notification){
        print("inside select quote convert")
        if let quote = notif.object as? Quote {
            print(quote)
            if let buttonId = notif.userInfo?[ConverterQuotes.BUTTON_TAG] as? String{
                print(quote.name)
                let image = UIImage(named: quote.name.lowercased())
                let myInt = (quote.percent_change_24h as NSString).integerValue
                if(Int(buttonId)  == 1){
                    baseValue = quote.price_usd
                    BaseSelectButton.setBackgroundImage(image, for: UIControl.State.normal)
                    BaseQuote.text = ("\(quote.name) - \(quote.price_usd)$")
                    if(myInt > 0){
                        baseImage.image = UIImage(named: "up")
                    }else{
                        baseImage.image = UIImage(named: "down")
                    }
                }else{
                    secondaryValue = quote.price_usd
                    SecondarySelectButton.setBackgroundImage(image, for: UIControl.State.normal)
                    SecondaryQuote.text = ("\(quote.name) - \(quote.price_usd)$")
                    if(myInt > 0){
                        SecondaryImage.image = UIImage(named: "up")
                    }else{
                        SecondaryImage.image = UIImage(named: "down")
                    }
                }
                
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let quotesConverterVC = segue.destination as? QuotesTableViewController {
            if let button = sender as? UIButton {
                quotesConverterVC.chooseQuote = true
                quotesConverterVC.converterButtonId = button.restorationIdentifier
            }
        }
    }
    
}

