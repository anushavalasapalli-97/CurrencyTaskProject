//
//  ViewController.swift
//  TaskAnusha
//
//  Created by Mouritech on 18/07/20.
//  Copyright © 2020 Mouritech. All rights reserved.
//

import UIKit
import GoogleSignIn
var strHomeCurrency = NSString()
class ViewController: UIViewController, UITextFieldDelegate {
    
    var aryCurrencies = NSDictionary()
    var sampleTextField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        //strHomeCurrency = ""
        // Do any additional setup after loading the view.
//        var error = NSError?.self
//        GGLContext.sharedInstance().configureWithError(&error)
        
        let signInButton = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        signInButton.center = view.center
        self.view .addSubview(signInButton)
        
        
         let button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
         button.backgroundColor = .red
         button.setTitle("Sign Out", for: .normal)
         button.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
         self.view.addSubview(button)
             

         sampleTextField =  UITextField(frame: CGRect(x: 100, y: button.frame.origin.y + button.frame.height + 20, width: 200, height: 50))
         // sampleTextField.placeholder = "Currency"
         sampleTextField.font = UIFont.systemFont(ofSize: 15)
         sampleTextField.textAlignment = .center
         sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        //  sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        //  sampleTextField.keyboardType = UIKeyboardType.default
        //  sampleTextField.returnKeyType = UIReturnKeyType.done
        //  sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
       //   sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
          sampleTextField.delegate = self
          self.view.addSubview(sampleTextField)
        
         let buttonConversion = UIButton(frame: CGRect(x: 100, y: sampleTextField.frame.origin.y + button.frame.height + 20, width: 200, height: 50))
         buttonConversion.backgroundColor = .red
         buttonConversion.setTitle("Conversion", for: .normal)
         buttonConversion.addTarget(self, action: #selector(didTapConversion), for: .touchUpInside)
         self.view.addSubview(buttonConversion)

         
        
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CurrencyViewController") as? CurrencyViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        // Automatically sign in the user.
       // GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        self.getCurrencies()
        
        
        

    }
    
    func getCurrencies(){

        // Create URL
        let url = URL(string: "https://api.exchangeratesapi.io/latest")
        guard let requestUrl = url else { fatalError() }
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
   
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")

                self.convertStringToDictionary(text: dataString)
                
            }
            
        }
        task.resume()
        
    }
     func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
               
                _ =  json?["date"]
                let strBase =  json?["base"]
                strHomeCurrency =  strBase as! NSString
                print("strHomeCurrency:%@",strHomeCurrency)
                DispatchQueue.main.async {
                    self.sampleTextField.text = strHomeCurrency as String
                }
                
                let strRates =  json?["rates"]
                aryCurrencies = [:]
                aryCurrencies = strRates as! NSDictionary
                return json
            } catch {
                print("Something! went wrong")
            }
        }
        return nil
    }
    

    @IBAction func didTapSignOut(_ sender: AnyObject) {
      GIDSignIn.sharedInstance().signOut()
    }
    
    @IBAction func didTapConversion(_ sender: AnyObject) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CurrencyViewController") as? CurrencyViewController
        vc?.aryCurrencies = [:]
        vc?.aryCurrencies = aryCurrencies
        self.present(vc!, animated: true, completion: nil)

        
    }
}

