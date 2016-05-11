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
    
    
    
    var queuedSongs: [Song] = []
    var currentSongURI: String?
    var player: SPTAudioStreamingController?
    var playOptions = SPTPlayOptions()
    static var sharedController = SongController()
    
    
    var delegate: updatePlayPauseLabel?
    
    func mockData() -> [Song]{
        //        let song1 = Song(name: "Fat Lip", playCount: 0, artist: Artist(name: "Sum 41") , album: Album(name: "All Killer, No Filler", artist: Artist(name: "Sum 41")), trackURI: "spotify:track:4KacUpvbA3Mfo05gttTjhN")
        //        let song2 = Song(name: "In Too Deep", playCount: 0, artist: Artist(name: "Sum 41"), album: Album(name: "All Killer, No Filler", artist: Artist(name: "Sum 41")), trackURI: "spotify:track:1HNE2PX70ztbEl6MLxrpNL")
        //        let song3 = Song(name: "Ocean Avenue", playCount: 0, artist: Artist(name: "Yellowcard"), album: Album(name: "Ocean Avenue",artist: Artist(name: "Yellowcard")), trackURI: "spotify:track:23oxJmDc1V9uLUSmN2LIvx")
        //        let song4 = Song(name: "Nerve", playCount: 0, artist: Artist(name: "The Story So Far"), album: Album(name: "The Story So Far", artist: Artist(name: "The Story So Far")), trackURI: "spotify:track:1DlT3Udf11689ezYr6R8aA")
        //        let song5 = Song(name: "The Things I Can't Change", playCount: 0, artist: Artist(name: "The Story So Far"), album: Album(name: "The Story So Far", artist: Artist(name: "The Story So Far")), trackURI: "spotify:track:0a96MZrTDKwvl1MTYvDP3o")
        //        return [song1, song2, song3, song4, song5]
        return []
    }
    
    func playPauseToggle() {
        if player?.isPlaying == true {
            player?.setIsPlaying(false, callback: nil)
            self.delegate?.playPauseLabelToggle(false)
        } else if player?.isPlaying == false {
            player?.setIsPlaying(true, callback: nil)
            self.delegate?.playPauseLabelToggle(true)
        }
    }
    
    func startSpotifySongs(completion: (success: Bool, queuedSongs: [NSURL]?) -> Void) {
//        if let localPlayer = self.player {
            var queuedSongs: [NSURL] = []
            SpotifyController.getUsersMusic({ (songs) in
                if let songs = songs {
                    for song in songs {
                        let songID = song.trackURI
                        queuedSongs.append(songID)
                    }
                    completion(success: true, queuedSongs: queuedSongs)
                } else {
                    completion(success: false, queuedSongs: nil)
                }
            })
//        } else {
//            completion(success: false, queuedSongs: nil)
//        }
    }
    
    //    func fetchUserLibrary() ->
    
    func setupSpotifyPlayer(session: SPTSession!, completion: (success: Bool, player: SPTAudioStreamingController?) -> Void) {
        player = SPTAudioStreamingController(clientId: SpotifyController.kClientID)
        if let player = player {
            player.playbackDelegate = self
            player.diskCache = SPTDiskCache(capacity: 1024 * 1024 * 64)
            player.loginWithSession(session, callback: { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(success: false, player: nil)
                } else {
                    completion(success: true, player: player)
                }
            })
            
        }
    }
    
    func updateUI() {
        
    }
    
    static func filterWordsFromURI(trackURI: String) -> String {
        let filteredURI = trackURI.stringByReplacingOccurrencesOfString("spotify:track:", withString: "")
        return filteredURI
    }
    
    func nextSong() {
        
        self.player?.skipNext({ (error) in
            self.delegate?.playPauseLabelToggle(true)
            if error != nil {
                print(error.localizedDescription)
            }
        })
        
    }
    
    func previousSong() {
        
        self.player?.skipPrevious({ (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            self.delegate?.playPauseLabelToggle(true)
            
        })
        
    }
    
    func addToQueue(songName: String, playCount: Int, artist: Artist, album: Album, trackURI: NSURL) {
        
        let song = Song(name: songName, playCount: playCount, artist: artist, album: album, trackURI: trackURI)
        self.queuedSongs.append(song)
    }
    
    func clearQueue()  {
        
        self.queuedSongs = []
    }
}