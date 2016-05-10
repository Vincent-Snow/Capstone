//
//  LoginViewController.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
    

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
        SPTAuthDefault.clientID = SpotifyController.kClientID
        SPTAuthDefault.redirectURL = NSURL(string: SpotifyController.kCallbackURL)
        SPTAuthDefault.requestedScopes = [SPTAuthStreamingScope, SPTAuthUserLibraryReadScope]
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
