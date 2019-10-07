//
//  Realm.swift
//  HomeWork3
//
//  Created by Aka on 24.09.19.
//  Copyright © 2019 Aka. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    func readQuotesFromStorage () -> [Quote]? {
        do {
            let realm = try Realm()
            return realm
                .objects(QuoteCached.self)
                .map{ Quote(fromCached: $0) } as [Quote]
            
        } catch let error as NSError {
            print("ERROR: \(error.localizedDescription)")
        }
        return nil
    }
    
    func writeQuotesToStorage (quotes: [Quote]) {
        quotes
            .map{QuoteCached(quote: $0)}
            .forEach{ quote in
                do {
                    let realm = try Realm()
                    try realm.write ({
                        realm.add(quote, update: .modified)
                    })
                } catch let error as NSError {
                    print("ERROR: \(error.localizedDescription)")
                }
        }
    }
}
