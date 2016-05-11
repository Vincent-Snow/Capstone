//
//  SpotifyController.swift
//  Capstone
//
//  Created by mac-admin on 4/4/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation

class SpotifyController: SPTYourMusic {
    
    static var session: SPTSession? {
        if let sessionObj: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("SpotifySession") {
            let sessionDataObject = sessionObj as! NSData
            let session = NSKeyedUnarchiver.unarchiveObjectWithData(sessionDataObject) as? SPTSession
            return session
        }
        return nil
    }
    
    
    static var playlistSongArray: [Song] = []
    
    static var player: SPTAudioStreamingController?
    
    static let kClientID = "a8bc39869a324c9b9e5f3f97b3126537"
    static let kCallbackURL = "capstone://returnAfterLogin"
    
    static func getImageForUrl(url: NSURL) -> UIImage? {
        if let imageData = NSData(contentsOfURL: url) {
            let image = UIImage(data: imageData)
            return image
            
        } else {
            
            return nil
        }
    }
    
    static func getUsersPlaylists(completion:(playlist:[SPTPartialPlaylist]?) -> Void)  {
        
        SPTPlaylistList.playlistsForUserWithSession(self.session) { (error, playlistList) in
            if let playlistList = playlistList as? SPTPlaylistList,
                playlists = playlistList.items as? [SPTPartialPlaylist] {
                for playlist in playlists {
                    let playlist = Playlist(uri: playlist.uri, name: playlist.name)
                }
                
                print(playlists)
                print(playlists)
            }
        }
    }
    static func getTracksFromPlaylist(playlist: Playlist, completion:(song: [Song]) -> Void) {
        SPTPlaylistSnapshot.playlistWithURI(playlist.uri, session: self.session, callback: { (error, playlist) in
            print(playlist)
            if let firstPage = playlist.firstTrackPage {
                for track in firstPage.items {
                    let artist = track.artists
                    let album = track.album
                    //                    let song = Song(name: track.name, album: track.album, trackURI: track.uri)
                    //                    playlistSongArray.append(song)
                }
                print(playlist.firstTrackPage)
            }
        })
        
        
    }
    
    
    static func getUsersMusic(completion:(songs: [Song]?) -> Void) {
        
        var allUsersSongs: [Song] = []
        
        if let token = session?.accessToken {
            savedTracksForUserWithAccessToken(token) { (error, list) in
                print(list)
                if error != nil {
                    completion(songs: nil)
                    print(error)
                } else {
                    if let list = list as? SPTListPage,
                        items = list.items {
                        for song in items {
                            guard let song = song as? SPTPartialTrack,
                                artists = song.artists as? [SPTPartialArtist],
                                album = song.album else {
                                    completion(songs: nil)
                                    return
                            }
                            let artist = artists[0]
                            let newSong = Song(name: song.name, artist: Artist(name: artist.name), album: Album(name: album.name), trackURI: song.uri)
                            allUsersSongs.append(newSong)
                        }
                        completion(songs: allUsersSongs)
                    } else {
                        completion(songs: nil)
                    }
                }
            }
        } else {
            completion(songs: nil)
        }
        
    }
    
    
    static func getTrackInfoFromTrackURI(songURL: String, completion: (song: Song?) -> Void) {
        if let url = NetworkController.spotifyURL(songURL) {
            NetworkController.dataAtURL(url, completion: { (data) in
                if let data = data {
                    do {
                        let jsonDict = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                        
                        guard let albumDict = jsonDict["album"] as? [String: AnyObject],
                            albumArtworkDict = jsonDict["album"] as? [String: AnyObject],
                            artistArray = jsonDict["artists"] as? [[String: AnyObject]],
                            songName = jsonDict["name"] as? String,
                            trackID = jsonDict["id"] as? String else {
                                completion(song: nil)
                                return
                        }
                        
                        if let artistDict = artistArray.first
                        {
                            let artist = Artist(name: artistDict["name"] as! String)
                            
                            let albumArray = albumArtworkDict["images"] as! [[String: AnyObject]]
                            
                            var albumArtwork: UIImage? = nil
                            var imageURL: String? = nil
                            if let firstAlbumImage = albumArray.first {
                                imageURL = firstAlbumImage["url"] as? String
                                if let imageURLString = imageURL {
                                    albumArtwork = SpotifyController.getImageForUrl(NSURL(string: imageURLString)!)
                                }
                            }
                            let trackURI = NSURL(string: trackID)
                            let album = Album(name: albumDict["name"] as! String)
                            
                            let song = Song(name: songName, playCount: 0, artist: artist, album: album, albumArtwork: albumArtwork, songURL: url, imageURL: imageURL, trackURI: trackURI!)
                            
                            print(jsonDict)
                            print(song)
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