//
//  QuoteProvider.swift
//  HomeWork3
//
//  Created by Aka on 03.09.19.
//  Copyright © 2019 Aka. All rights reserved.
//

import Foundation
import UIKit
class QuoteProvider {
    
//    let nameContent = ["bitcoin","ethereum","ripple","bitcoin-cash","litecoin","tether","binance-coin","eos","bitcoin-sv","monero","stellar","cardano"]
//    let symbolContent = ["BTC","ETH","XRP","BCH","LTC","USDT","BNB","EOS","BSV","XMR","XLM","ADA",]
//    let rankContent = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
//    let priceUsdContent = [10358.7323762, 176.940243703, 0.2602659432, 295.794303869, 67.535401015, 1.0039213973, 22.5150990285, 3.334197551, 134.610596848, 73.8289523771, 0.0629794006, 0.0450806682]
//    let h24Content = [18613539635.2, 6931506660.85, 1064741269.32, 1366444823.92, 2537307716.39, 20546648538.2, 240061090.581, 1379948395.01, 309185985.472, 69677282.1605, 86095930.915, 48101893.456]
//    let markContent = [185555579423, 19036500577, 11187442072, 5319150649, 4266394405, 4022381472, 3501924496, 3101306008, 2403470289, 1269034603, 1236924232, 1168809664]
//    let availableSupply = [17924525.0,107665940.0,42984656144.0,17992975.0,63214317.0,4071193568.0,155536713.0,930950840.0,17854986.0,17198751.0,25927070538.0,19747411152.0]
//    let percentChange = [-2.11,-1.55,-1.37,-1.87,-2.2,-0.05,-1.94,1.26,-2.19,-2.74,-2.8,0.17]
    
    @objc func loadQuotes() {
        let jsonUrlString = "https://api.coinmarketcap.com/v1/ticker/"
        guard let objurl = URL(string: jsonUrlString) else {
            print("Ошибка в URL строке")
            return
        }
        
        let receiveQuotesTask = URLSession.shared.dataTask(with: objurl) {
            (data, responce, error) in
            if let data = data, let quotes = try? JSONDecoder().decode([Quote].self, from: data) {
                DispatchQueue.main.async {
                    print("quotes: \(quotes.count)")
                    NotificationCenter.default.post(name: NSNotification.Name("quotes"), object: quotes)
                }
            }
        }
        receiveQuotesTask.resume()
    }
    
}
