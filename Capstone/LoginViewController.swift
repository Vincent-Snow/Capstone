//
//  LoginViewController.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
    var usersSongs: [Song] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(getUserMusic), name: "LoginSuccessful", object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTaped(sender: AnyObject) {
        SpotifyController.authorizeUser { 
       }
        
    }
    
    func getUserMusic() {
        SpotifyController.getUsersMusic({ (songs) in
            guard let songs = songs else {return}
            SongController.sharedController.songs = songs
        })
    }

}
