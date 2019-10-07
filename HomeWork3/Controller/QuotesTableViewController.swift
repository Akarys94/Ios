//
//  QuotesTableViewController.swift
//  HomeWork3
//
//  Created by Aka on 03.09.19.
//  Copyright © 2019 Aka. All rights reserved.
//

import UIKit
import AnimatableReload

class QuotesTableViewController: UITableViewController {
    
    let quoteProvider = QuoteProvider()
    var quotes = [Quote]()
     private let realm = RealmHelper()
    var chooseQuote = false
    var converterButtonId: String?
    @IBOutlet weak var baseQuoteIconButton: UIButton!
    // MARK: - Table view data source
    override func viewDidLoad() {
//        quoteProvider.loadQuotes()
        if let quotes = realm.readQuotesFromStorage(), quotes.count != 0 {
            self.quotes = quotes
        } else {
            quoteProvider.loadQuotes()
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateDataTimer),
                                               name: Notification.Name("quotes"),
                                               object: nil)
        //       Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(quoteProvider.loadQuotes ), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func refreshButtons(_ sender: UIButton) {
        quoteProvider.loadQuotes()
        print("ok")
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    @objc func updateDataTimer(notif: Notification){
        if let quotes = notif.object as? [Quote] {
            self.quotes = quotes
            AnimatableReload.reload(tableView: tableView, animationDirection: "down")
            if(chooseQuote){
                print("ok now")
            }
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let quote = quotes[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as? QuoteCell {
            cell.quoteLabel.text = quote.name.uppercased()
            cell.coinsImage.image = UIImage(named: quote.name.lowercased())
            cell.timeDifference.text = quote.percent_change_24h
            let myInt = (quote.percent_change_24h as NSString).integerValue
            if(myInt > 0){
                cell.timeDifference.textColor! = UIColor.green
                cell.progressImage.image = UIImage(named: "up")
            }else{
                cell.timeDifference.textColor! = UIColor.red
                cell.progressImage.image = UIImage(named: "down")
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quote = quotes[indexPath.row]
        NotificationCenter.default.post(name: NSNotification.Name(ConverterQuotes.NOTIFIC_SELECTED_QUOTE),object: quote, userInfo:[ConverterQuotes.BUTTON_TAG: converterButtonId ?? 0])
        dismiss(animated: true, completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return converterButtonId == nil
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "quotesToDetail"{
            if let cell = sender as? QuoteCell{
                
                if let indexPath = tableView.indexPath(for: cell){
                    let quote = quotes[indexPath.row]
                    let detailVC = segue.destination as? QuoteDetailViewCellViewController
                    detailVC?.quote = quote
                    
                }
            }
            
        } 
    }
    
}
