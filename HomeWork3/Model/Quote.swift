//
//  Quote.swift
//  HomeWork3
//
//  Created by Aka on 03.09.19.
//  Copyright © 2019 Aka. All rights reserved.
//

import Foundation
struct Quote: Decodable {
    var id: String
    var name: String
    var symbol: String
    var rank: String
    var price_usd: String
    var price_btc: String
    var volume_usd_24: String
    var market_cap_usd: String
    var available_supply: String
    var total_supply: String
    var max_supply: String?
    var percent_change_1h: String
    var percent_change_24h: String
    var percent_change_7d: String
    var last_updated: String
    enum CodingKeys:String,CodingKey {
        case id
        case name
        case symbol
        case rank
        case price_usd
        case price_btc
        case volume_usd_24 = "24h_volume_usd"
        case market_cap_usd
        case available_supply
        case total_supply
        case max_supply
        case percent_change_1h
        case percent_change_24h
        case percent_change_7d
        case last_updated
    }
    init(fromCached cached:QuoteCached){
        self.id = cached.id
        self.name = cached.name
        self.symbol = cached.symbol
        self.id = cached.id
        self.rank = cached.rank
        self.price_usd = cached.price_usd
        self.price_btc = cached.price_btc
        self.volume_usd_24 = cached.volume_usd_24
        self.market_cap_usd = cached.market_cap_usd
        self.available_supply = cached.available_supply
        self.total_supply = cached.total_supply
        self.max_supply = cached.max_supply
        self.percent_change_1h = cached.percent_change_1h
        self.percent_change_24h = cached.percent_change_24h
        self.percent_change_7d = cached.percent_change_7d
        self.last_updated = cached.last_updated
    }
    //    static func quote(fromCached cached: QuoteCached) -> Quote {
    //        let quote = [Quote]()
    //        quote.
    //
    //        quote.id = id
    //        quote.name = name
    //        quote.symbol = symbol
    //        quote.rank = rank
    //        quote.price_usd = price_usd
    //        quote.price_btc = price_btc
    //        quote.volume_usd_24 = volume_usd_24
    //        quote.market_cap_usd = market_cap_usd
    //        quote.available_supply = available_supply
    //        quote.total_supply = total_supply
    //        quote.max_supply = max_supply
    //        quote.percent_change_1h = percent_change_1h
    //        quote.percent_change_24h = percent_change_24h
    //        quote.percent_change_7d = percent_change_7d
    //        quote.last_updated = last_updated
    //        return quote
    //    }
}
