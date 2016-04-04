//
//  PlayerViewController.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import UIKit



class PlayerViewController: UIViewController, updatePlayPauseLabel, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate  {
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
    var player: SPTAudioStreamingController?
    
    static let kClientID = "a8bc39869a324c9b9e5f3f97b3126537"
    static let kCallbackURL = "capstone://returnAfterLogin"
    
    var session: SPTSession? {
        if let sessionObj: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("SpotifySession") {
            let sessionDataObject = sessionObj as! NSData
            let session = NSKeyedUnarchiver.unarchiveObjectWithData(sessionDataObject) as? SPTSession
            return session
        }
        return nil
    }
    //var player: SPTAudioStreamingController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SongController.sharedController.delegate = self
        
        self.player?.delegate = self
        self.player?.playbackDelegate = self
        SongController.sharedController.player = self.player
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playPauseLabelToggle(isPlaying: Bool) {
        if isPlaying == true {
            playPauseButton.setTitle("Pause", forState: .Normal)
        } else {
            playPauseButton.setTitle("Play", forState: .Normal)
        }
    }
    
    func artistSongAlbumLabelUpdate() {
        artistNameLabel.text = SongController.sharedController.mockData()[0].artist.name
        songNameLabel.text = SongController.sharedController.mockData()[0].name
        
    }
    
    @IBAction func playPauseButtonTapped(sender: AnyObject) {
        SongController.sharedController.playPauseToggle()
        
    }
    
    @IBAction func previousTrackButtonTapped(sender: AnyObject) {
        SongController.sharedController.previousSong()
        player?.currentTrackURI
    }
    
    @IBAction func nextTrackButtonTapped(sender: AnyObject) {
        SongController.sharedController.nextSong()
    }
    
    @IBAction func addToQueueTapped(sender: UIButton) {
        sender.hidden = true
        //SongController.sharedController.addToQueue()
    }
    
    func audioStreamingDidSkipToNextTrack(audioStreaming: SPTAudioStreamingController!) {
        print("Did go to next")
        
    }
    
    func audioStreamingDidSkipToPreviousTrack(audioStreaming: SPTAudioStreamingController!) {
        print("Did go to previous")
    }

//    func switchToPlay() {
//        if player?.isPlaying != nil {
//            playPauseButton.setTitle("Pause", forState: .Normal)
//        }
//    }
//    
//    func switchToPause() {
//        if player?.setIsPlaying(true, callback: nil) == nil {
//            playPauseButton.setTitle("Play", forState: .Normal)
//        }
//        
    

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
