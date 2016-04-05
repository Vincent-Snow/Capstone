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
    
    var queuedSongs: [Song] = []
    
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
    
    func playPauseToggle() {
        if player?.isPlaying == nil {
            //startSpotifySongWithID(self.mockData()[0].trackURI)
            startSpotifySongs()
            //startSpotifySongWithID("spotify:user:1260449223:playlist:38fJ1O7mxqTsTevRih46yY")
            self.delegate?.playPauseLabelToggle(true)
        } else if player?.isPlaying == true {
            player?.setIsPlaying(false, callback: nil)
            self.delegate?.playPauseLabelToggle(false)
        } else if player?.isPlaying == false {
            player?.setIsPlaying(true, callback: nil)
            self.delegate?.playPauseLabelToggle(true)
        }
    }
    
    func startSpotifySongs() {
//        let spotifyURI = songID
        setupSpotifyPlayer(session!) { (success) in
            if success {
                if let localPlayer = self.player {
                    var songs: [NSURL] = []
                    for song in self.mockData()
                    {
                        let songID = song.trackURI
                        if let spotifyURL = NSURL(string: songID) {
                            songs.append(spotifyURL)
                        }
                    }
                    localPlayer.playURIs(songs, withOptions: self.playOptions, callback: nil)
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
    
    func getSongInfoWithURI(trackURI: String) {
        
    }
    
    func nextSong() {
        self.player?.skipNext({ (error) in
            self.delegate?.playPauseLabelToggle(true)
            print("sick")
        })
        
    }
    
    func previousSong() {
        self.player?.skipPrevious({ (error) in
            self.delegate?.playPauseLabelToggle(true)
            print("nicedude")
        })
        
    }

    func addToQueue(songName: String, playCount: Int, artist: Artist, album: Album, trackURI: String) {
        let song = Song(name: songName, playCount: playCount, artist: artist, album: album, trackURI: trackURI)
        self.queuedSongs.append(song)
    }
    
    func clearQueue()
    {
        self.queuedSongs = []
    }
}