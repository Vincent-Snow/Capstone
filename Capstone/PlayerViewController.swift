//
//  PlayerViewController.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import UIKit
import Foundation



class PlayerViewController: UIViewController, updatePlayPauseLabel, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate  {
    
    @IBOutlet weak var albumArtImage: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
    
    var currentTrackURI: String?
    var player: SPTAudioStreamingController?
    var queuedSongs: [Song]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let playImage = UIImage(named: "Play")?.imageWithRenderingMode(.AlwaysOriginal)
        playPauseButton.setImage(playImage, forState: .Normal)
        
        songNameLabel.text = "Nothing Playing"
        artistNameLabel.text = ""
        albumArtImage.image = UIImage(named: "NoImage")
        
        SongController.sharedController.delegate = self
        
        SpotifyController.player?.delegate = self
        SpotifyController.player?.playbackDelegate = self
        SongController.sharedController.setupSpotifyPlayer(SpotifyController.session!) { (success, player) in
            SongController.sharedController.startSpotifySongs({ (success, queuedSongs) in
                if let player = player, songURLs = queuedSongs {
                    self.player = player
                    player.queueURIs(songURLs, clearQueue: true, callback: nil)
                    player.setIsPlaying(true, callback: nil)
                    if let trackURI = songURLs.first {
                        let filteredURI = SongController.filterWordsFromURI(trackURI.absoluteString)
                        SpotifyController.getTrackInfoFromTrackURI(filteredURI, completion: { (song) in
                            if let song = song {
                                dispatch_async(dispatch_get_main_queue(), {
                                    
                                    self.artistSongAlbumLabelUpdate(song)
                                })
                                
                            }
                        })
                    }
                }
            })
        }
    }
    
    func playPauseLabelToggle(isPlaying: Bool) {
        
        if isPlaying == true {
            let pauseImage = UIImage(named: "Pause")?.imageWithRenderingMode(.AlwaysOriginal)
            playPauseButton.setImage(pauseImage, forState: .Normal)
        } else {
            let playImage = UIImage(named: "Play")?.imageWithRenderingMode(.AlwaysOriginal)
            playPauseButton.setImage(playImage, forState: .Normal)
        }
    }
    
    func artistSongAlbumLabelUpdate(song: Song) {
        artistNameLabel.text = song.artist.name
        songNameLabel.text = song.name
        
        
        if let artwork = song.albumArtwork {
            albumArtImage.image = artwork
            
        } else {
            //THIS SHOULD BE WHERE YOU SET A DEFAULT "NO IMG" IMAGE
            albumArtImage.image = UIImage(named: "NoImage")
        }
    }
    
    @IBAction func playPauseButtonTapped(sender: AnyObject) {
        SongController.sharedController.playPauseToggle()
        updateUI()
    }
    
    @IBAction func previousTrackButtonTapped(sender: AnyObject) {
        self.player?.skipPrevious({ (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.updateUI()
            }
        })
    }
    
    @IBAction func nextTrackButtonTapped(sender: AnyObject) {
        self.player?.skipNext({ (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.updateUI()
            }
        })
    }
    
    func updateUI() {
        if let trackURI = SongController.sharedController.player?.currentTrackURI {
            let filteredURI = SongController.filterWordsFromURI(trackURI.absoluteString)
            SpotifyController.getTrackInfoFromTrackURI(filteredURI, completion: { (song) in
                if let song = song {
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.artistSongAlbumLabelUpdate(song)
                    })
                    
                }
            })
        }
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
