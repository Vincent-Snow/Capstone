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
    
    
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let playImage = UIImage(named: "Play")?.imageWithRenderingMode(.AlwaysOriginal)
        playPauseButton.setImage(playImage, forState: .Normal)
        PlaylistController.sharedPlaylistController.fetchPlaylists()
        
        SongController.sharedController.delegate = self
        
        SpotifyController.player?.delegate = self
        SpotifyController.player?.playbackDelegate = self
        SongController.sharedController.player = SpotifyController.player
        
        SpotifyController.getTrackInfoFromTrackURI("2lbAU3IQytWjl9b0LLuztk", completion: { (song) in
            if let song = song
            {
                dispatch_async(dispatch_get_main_queue(), { 
                   
                    self.artistSongAlbumLabelUpdate(song)
                })
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
    
    @IBAction func playPauseButtonTapped(sender: AnyObject) {
        SongController.sharedController.playPauseToggle()
        
    }
    
    @IBAction func previousTrackButtonTapped(sender: AnyObject) {
        SongController.sharedController.previousSong()
        SpotifyController.player?.currentTrackURI
    }
    
    @IBAction func nextTrackButtonTapped(sender: AnyObject) {
        SongController.sharedController.nextSong()
    }
    
  
    
    func audioStreamingDidSkipToNextTrack(audioStreaming: SPTAudioStreamingController!) {
        print("Did go to next")
        
    }
    
    func audioStreamingDidSkipToPreviousTrack(audioStreaming: SPTAudioStreamingController!) {
        print("Did go to previous")
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
