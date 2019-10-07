//
//  QuoteDetailViewCellViewController.swift
//  HomeWork3
//
//  Created by Aka on 04.09.19.
//  Copyright © 2019 Aka. All rights reserved.
//

import UIKit
import AVKit

class QuoteDetailViewCellViewController: UIViewController {
    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var symbolLable: UILabel!
    @IBOutlet weak var rankLable: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var h24Lable: UILabel!
    @IBOutlet weak var marketLable: UILabel!
    @IBOutlet weak var availableLable: UILabel!
    @IBOutlet weak var percentLable: UILabel!
    @IBOutlet weak var updateDate: UILabel!
    
    var quote: Quote?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let quote = self.quote {
            self.title = quote.name
            nameLable.text = quote.name
            symbolLable.text = quote.symbol
            rankLable.text = quote.rank
            priceLable.text =  quote.price_usd
            h24Lable.text =  quote.percent_change_24h
            marketLable.text =  quote.market_cap_usd
            availableLable.text = quote.available_supply
            percentLable.text = quote.percent_change_1h
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "dd/MM/YYYY     hh:mm     a"
        let currentDateTime = Date()
        updateDate.text = dateFormatter.string(from: currentDateTime)
    }
    override func viewDidAppear(_ animated: Bool) {
            let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: (quote?.name)!)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            synthesizer.speak(utterance)
    }
    override func viewDidDisappear(_ animated: Bool) {
    }

}
