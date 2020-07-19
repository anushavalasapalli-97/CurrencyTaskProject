//
//  CurrencyViewController.swift
//  TaskAnusha
//
//  Created by Mouritech on 18/07/20.
//  Copyright © 2020 Mouritech. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
var aryCurrencies = NSDictionary()
var valueArray: [NSNumber] = []
var currencyArray: [String] = []
    
    @IBOutlet weak var tableViewCurrencies: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCurrencies.delegate = self
        tableViewCurrencies.dataSource = self
        for (key, value) in aryCurrencies {
               print("key is - \(key) and value is - \(value)")
            currencyArray.append(key as? String ?? "")
            valueArray.append(value as? NSNumber ?? 0)
           }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aryCurrencies.count
       }
       
       // create a cell for each table view row
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           // create a new cell if needed or reuse an old one
        let cell:CurrenciesTableViewCell = self.tableViewCurrencies.dequeueReusableCell(withIdentifier: "Currency") as! CurrenciesTableViewCell
           let value = valueArray[indexPath.row]
           let key = currencyArray[indexPath.row]
         
            print("ANUS:%@",value)
            cell.lblCurrencyMoney.text = key as? String
            let str = value
             print("str:%@",str)
        cell.lblCurrencyType.text = value.stringValue
            
 
        
           return cell
       }
       
       // method to run when table view cell is tapped
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("You tapped cell number \(indexPath.row).")
       }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
