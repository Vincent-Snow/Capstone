//
//  PlayerViewController.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    let kClientID = "595ff16788c34cb2b9f8252668e55406"
    let kCallbackURL = "prototypekeyfeature://returnafterlogin"
    
    //var session:
    var player: SPTAudioStreamingController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playPauseButtonTapped(sender: AnyObject) {
        if player == nil {
            player = SPTAudioStreamingController(clientId: kClientID)
        }
        let session = SPTSession(userName: <#T##String!#>, accessToken: <#T##String!#>, expirationTimeInterval: <#T##NSTimeInterval#>)
        player?.loginWithSession(session, callback: { (error:NSError!) in
            if error != nil {
                print("track error")
                return
            }
            SPTRequest.requestItemAtURI(NSURL(string: SongController.mockData()[0].trackURI), withSession: session, callback: {
                (error: NSError!, track: AnyObject!) -> Void in
                if error != nil {
                    
                }
            })
        })
        
        
        
        
        
    }
    
    @IBAction func previousTrackButtonTapped(sender: AnyObject) {
        
    }
    
    @IBAction func nextTrackButtonTapped(sender: AnyObject) {
        
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
