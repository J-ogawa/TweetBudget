//
//  FirstViewController.swift
//  TweetBudget
//
//  Created by conilus on 11/11/14.
//  Copyright (c) 2014 debussynetwork. All rights reserved.
//

import UIKit
import Social
import Accounts

class FirstViewController: UIViewController {
    
    @IBOutlet weak var itemField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var itemPicker: UIPickerView!
    @IBOutlet weak var pricePicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    func tweet(text: String) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) {
            granted, error in
            
            if granted {
                let twitterAccounts = accountStore.accountsWithAccountType(accountType)
                
                if (twitterAccounts != nil) {
                    if twitterAccounts.count == 0 {
                        println("There are no Twitter accounts configured. You can add or create a Twitter account in Settings.")
                    }
                    else {
                        let twitterAccount = twitterAccounts[0] as ACAccount
                        let url = NSURL(string: "https://api.twitter.com/1/statuses/update.json")
                        let params = NSDictionary(object: "食材 ¥500", forKey: "status")
                        var request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.POST, URL: url, parameters: params)
                        request.account = twitterAccount
                        request.performRequestWithHandler({ (responseData, urlResponse, error) -> Void in
                            let resStr = NSString(data: responseData, encoding: NSUTF8StringEncoding)
                        })
                    }
                }
                else {
                    println("There are no Twitter accounts configured. You can add or create a Twitter account in Settings.")
                }
            }
            println("aaa")
        }
    }
}

