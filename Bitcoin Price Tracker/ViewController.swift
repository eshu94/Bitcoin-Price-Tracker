//
//  ViewController.swift
//  Bitcoin Price Tracker
//
//  Created by ESHITA on 27/10/19.
//  Copyright © 2019 ESHITA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inrLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var euroLabel: UILabel!
    @IBOutlet weak var currencyImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getDefaultPrices()
        getPrice()
    }
    func getDefaultPrices(){
        
        let inrPrice =  UserDefaults.standard.double(forKey: "INR")
        let usdPrice =  UserDefaults.standard.double(forKey: "USD")
        let eurPrice =  UserDefaults.standard.double(forKey: "EUR")
        
        if inrPrice != 0.0 {
            let inrString = self.currencyFormatter(price: inrPrice, currencyCode: "INR")
            self.inrLabel.text = inrString + "~"
        }
        if usdPrice != 0.0 {
            let usdString = self.currencyFormatter(price: usdPrice, currencyCode: "USD")
            self.usdLabel.text = usdString + "~"
        }
        if eurPrice != 0.0 {
            let eurString = self.currencyFormatter(price: eurPrice, currencyCode: "EUR")
            self.euroLabel.text = eurString + "~"
        }
        
    }
    func getPrice(){
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=INR,USD,EUR"){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    if let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Double]{
                        if let jsonDictionry = jsonData {
                            DispatchQueue.main.async {
                                if let inrPrice = jsonDictionry["INR"] {
                                    let inrString = self.currencyFormatter(price: inrPrice, currencyCode: "INR")
                                    self.inrLabel.text = inrString
                                    UserDefaults.standard.set(inrPrice, forKey: "INR")
                                    //self.currencyImage.image = UIImage(named: "bitcoinINR")
                                }
                                if let usdPrice = jsonDictionry["USD"] {
                                    let usdString = self.currencyFormatter(price: usdPrice, currencyCode: "USD")
                                    self.usdLabel.text = usdString
                                    UserDefaults.standard.set(usdPrice, forKey: "USD")
                                    //self.currencyImage.image = UIImage(named: "bitcoinUSD")
                                }
                                if let euroPrice = jsonDictionry["EUR"] {
                                    let eurString = self.currencyFormatter(price: euroPrice, currencyCode: "EUR")
                                    self.euroLabel.text = eurString
                                    UserDefaults.standard.set(euroPrice, forKey: "EUR")
                                    //self.currencyImage.image = UIImage(named: "bitcoinEUR")
                                    
                                }
                                UserDefaults.standard.synchronize()
                            }
                        }
                    }
                }else{
                    print("error")
                }
                }.resume()
        }
    }
    
    func currencyFormatter(price: Double, currencyCode: String) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        let priceString = formatter.string(from: NSNumber(value: price))
        if priceString == nil {
            return "Error"
        }else {
            return priceString!
        }
    }
    
    @IBAction func refershTapped(_ sender: Any) {
        currencyImage.image = UIImage(named: "bitcoinINR")
        getPrice()
    }
    
    @IBAction func inrTapped(_ sender: Any) {
        let inrPrice1 =  UserDefaults.standard.double(forKey: "INR")
        let usdPrice1 =  UserDefaults.standard.double(forKey: "USD")
         let eurPrice1 =  UserDefaults.standard.double(forKey: "EUR")
        inrLabel.text = currencyFormatter(price: inrPrice1, currencyCode: "INR")
        usdLabel.text = currencyFormatter(price: usdPrice1, currencyCode: "USD")
        euroLabel.text = currencyFormatter(price: eurPrice1, currencyCode: "EUR")
        currencyImage.image = UIImage(named: "bitcoinINR")
        
    }
    
    @IBAction func usdTapped(_ sender: Any) {
        
        let inrPrice1 =  UserDefaults.standard.double(forKey: "INR")
        let usdPrice1 =  UserDefaults.standard.double(forKey: "USD")
        let eurPrice1 =  UserDefaults.standard.double(forKey: "EUR")
        inrLabel.text = currencyFormatter(price: usdPrice1, currencyCode: "USD")
        usdLabel.text = currencyFormatter(price: inrPrice1, currencyCode: "INR")
        euroLabel.text = currencyFormatter(price: eurPrice1, currencyCode: "EUR")
        currencyImage.image = UIImage(named: "bitcoinUSD")

    }
    
    @IBAction func eurTapped(_ sender: Any) {
        let inrPrice1 =  UserDefaults.standard.double(forKey: "INR")
        let usdPrice1 =  UserDefaults.standard.double(forKey: "USD")
        let eurPrice1 =  UserDefaults.standard.double(forKey: "EUR")
        inrLabel.text = currencyFormatter(price: eurPrice1, currencyCode: "EUR")
        usdLabel.text = currencyFormatter(price: inrPrice1, currencyCode: "INR")
        euroLabel.text = currencyFormatter(price: usdPrice1, currencyCode: "USD")
        currencyImage.image = UIImage(named: "bitcoinEUR")

    }
}

