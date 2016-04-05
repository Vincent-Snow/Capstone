//
//  SpotifyController.swift
//  Capstone
//
//  Created by mac-admin on 4/4/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation

class SpotifyController {
    
    static var session: SPTSession? {
        if let sessionObj: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("SpotifySession") {
            let sessionDataObject = sessionObj as! NSData
            let session = NSKeyedUnarchiver.unarchiveObjectWithData(sessionDataObject) as? SPTSession
            return session
        }
        return nil
    }
    
    static var player: SPTAudioStreamingController?
    
    static let kClientID = "a8bc39869a324c9b9e5f3f97b3126537"
    static let kCallbackURL = "capstone://returnAfterLogin"
    
    
    static func getTrackInfoFromTrackURI(trackURI: String, completion: (song: Song?) -> Void) {
        if let url = NetworkController.spotifyURL(trackURI) {
            NetworkController.dataAtURL(url, completion: { (data) in
                if let data = data {
                    do {
                        let jsonDict = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                        
                        guard let albumDict = jsonDict["album"] as? [String: AnyObject],
                            artistArray = jsonDict["artists"] as? [[String: AnyObject]],
                            songName = jsonDict["name"] as? String ,
                            trackID = jsonDict["id"] as? String else {
                                completion(song: nil)
                                return
                        }
                        
                        if let artistDict = artistArray.first
                        {
                            let artist = Artist(name: artistDict["name"] as! String)
                            
                            let album = Album(name: albumDict["name"] as! String, artist: artist)
                            
                            let song = Song(name: songName, playCount: 0, artist: artist, album: album, trackURI: trackID)
                            
                            print(jsonDict)
                            print("success")
                            
                            completion(song: song)
                        }
                    }
                    catch let error as NSError {
                        print("Could not serialize data \(error.localizedDescription) -> \(#function)")
                    }
                }
            })
        }
    }
}