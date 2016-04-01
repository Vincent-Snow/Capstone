//
//  SongController.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation
import UIKit

protocol updatePlayPauseLabel {
    
    func playPauseLabelToggle(isPlaying: Bool)
    
}

class SongController: NSObject, SPTAudioStreamingPlaybackDelegate {
    
    let kClientID = "a8bc39869a324c9b9e5f3f97b3126537"
    let kCallbackURL = "capstone://returnAfterLogin"
    
    var session: SPTSession? {
        if let sessionObj: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("SpotifySession") {
            let sessionDataObject = sessionObj as! NSData
            let session = NSKeyedUnarchiver.unarchiveObjectWithData(sessionDataObject) as? SPTSession
            return session
        }
        return nil
    }
    var player: SPTAudioStreamingController?
    var playOptions = SPTPlayOptions()
    static var sharedController = SongController()
    
    var delegate: updatePlayPauseLabel?
    
    
    
    func mockData() -> [Song]{
        let song1 = Song(name: "Fat Lip", playCount: 0, artist: Artist(name: "Sum 41") , album: Album(name: "All Killer, No Filler", artist: Artist(name: "Sum 41")), trackURI: "spotify:track:4KacUpvbA3Mfo05gttTjhN")
        let song2 = Song(name: "In Too Deep", playCount: 0, artist: Artist(name: "Sum 41"), album: Album(name: "All Killer, No Filler", artist: Artist(name: "Sum 41")), trackURI: "spotify:track:1HNE2PX70ztbEl6MLxrpNL")
        let song3 = Song(name: "Ocean Avenue", playCount: 0, artist: Artist(name: "Yellowcard"), album: Album(name: "Ocean Avenue",artist: Artist(name: "Yellowcard")), trackURI: "spotify:track:23oxJmDc1V9uLUSmN2LIvx")
        let song4 = Song(name: "Nerve", playCount: 0, artist: Artist(name: "The Story So Far"), album: Album(name: "The Story So Far", artist: Artist(name: "The Story So Far")), trackURI: "spotify:track:1DlT3Udf11689ezYr6R8aA")
        let song5 = Song(name: "The Things I Can't Change", playCount: 0, artist: Artist(name: "The Story So Far"), album: Album(name: "The Story So Far", artist: Artist(name: "The Story So Far")), trackURI: "spotify:track:0a96MZrTDKwvl1MTYvDP3o")
        return [song1, song2, song3, song4, song5]
    }
    
    //    func playSong() {
    //        if  let player = player {
    //            self.player = SPTAudioStreamingController(clientId: kClientID)
    //            player.loginWithSession(session, callback: { (error:NSError!) in
    //                if error != nil {
    //                    print("track error")
    //                    return
    //                }
    //                if let uri = NSURL(string: "spotify:track:23oxJmDc1V9uLUSmN2LIvx") {
    //                    player.playURIs([uri] , fromIndex: 0, callback: { (error: NSError!) in
    //                        if error != nil {
    //                            print("Starting playback got error")
    //                        }
    //                    })
    //                }
    //            })
    //        }
    //    }
    
    
    
    func playPauseToggle() {
        if player?.isPlaying == nil {
            startSpotifySongWithID("4KacUpvbA3Mfo05gttTjhN")
            self.delegate?.playPauseLabelToggle(true)
        } else if player?.isPlaying == true {
            player?.setIsPlaying(false, callback: nil)
            self.delegate?.playPauseLabelToggle(false)
        } else {
            player?.setIsPlaying(true, callback: nil)
            self.delegate?.playPauseLabelToggle(true)
        }
    }
    
    func startSpotifySongWithID(songID: String) {
        let spotifyURI = "spotify:track:\(songID)"
        setupSpotifyPlayer(session!) { (success) in
            if success {
                if let localPlayer = self.player {
                    if let spotifyURL = NSURL(string: spotifyURI) {
                        localPlayer.playURIs([spotifyURL], withOptions: self.playOptions, callback: nil)
                    }
                }
            }
        }
    }
    
    func setupSpotifyPlayer(session: SPTSession!, completion: (success: Bool) -> Void) {
        player = SPTAudioStreamingController(clientId: kClientID)
        if let player = player {
            player.playbackDelegate = self
            player.diskCache = SPTDiskCache(capacity: 1024 * 1024 * 64)
            player.loginWithSession(session, callback: { (error) in
                if let error = error {
                    // Awesome error handling
                    completion(success: false)
                } else {
                    completion(success: true)
                }
            })
            
        }
    }
    
    func audioStreamingDidSkipToNextTrack(audioStreaming: SPTAudioStreamingController!) {
        if player == nil {
            setupSpotifyPlayer(session, completion: { (success) in
                self.player?.skipNext({ (error) in
                    print("nice work vince")
                })
            })
        }
    }
    
    
    @objc func audioStreaming(audioStreaming: SPTAudioStreamingController!, didStopPlayingTrack trackUri: NSURL!) {
        //
    }
}