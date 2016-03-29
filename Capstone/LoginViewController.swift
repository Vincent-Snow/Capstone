//
//  LoginViewController.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
    let kClientID = "595ff16788c34cb2b9f8252668e55406"
    let kCallbackURL = "prototypekeyfeature://returnafterlogin"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTaped(sender: AnyObject) {
        let SPTAuthDefault = SPTAuth.defaultInstance()
        SPTAuthDefault.clientID = kClientID
        SPTAuthDefault.redirectURL = NSURL(string: kCallbackURL)
        SPTAuthDefault.requestedScopes = [SPTAuthStreamingScope]
        let auth = SPTAuthDefault.loginURL
        UIApplication.sharedApplication().openURL(auth)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
