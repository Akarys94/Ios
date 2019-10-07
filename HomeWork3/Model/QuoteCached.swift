//
//  QuoteCached.swift
//  HomeWork3
//
//  Created by Aka on 24.09.19.
//  Copyright © 2019 Aka. All rights reserved.
//

import Foundation
import RealmSwift

class QuoteCached: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var symbol: String = ""
    @objc dynamic var rank: String = ""
    @objc dynamic var price_usd: String = ""
    @objc dynamic var price_btc: String = ""
    @objc dynamic var volume_usd_24: String = ""
    @objc dynamic var market_cap_usd: String = ""
    @objc dynamic var available_supply: String = ""
    @objc dynamic var total_supply: String = ""
    @objc dynamic var max_supply: String = ""
    @objc dynamic var percent_change_1h: String = ""
    @objc dynamic var percent_change_24h: String = ""
    @objc dynamic var percent_change_7d: String = ""
    @objc dynamic var last_updated: String = ""
    
    
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    
    convenience init (quote: Quote) {
        self.init()
        id = quote.id
        name = quote.name
        symbol = quote.symbol
        rank = quote.rank
        price_usd = quote.price_usd
        price_btc = quote.price_btc
        volume_usd_24 = quote.volume_usd_24
        market_cap_usd = quote.market_cap_usd
        available_supply = quote.available_supply
        total_supply = quote.total_supply
        max_supply = (quote.max_supply)!
        percent_change_1h = quote.percent_change_1h
        percent_change_24h = quote.percent_change_24h
        percent_change_7d = quote.percent_change_7d
        last_updated = quote.last_updated
    }
    
    
}

