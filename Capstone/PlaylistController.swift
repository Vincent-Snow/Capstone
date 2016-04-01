//
//  PlaylistController.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation

class PlaylistController {
    
    static var sharedPlaylistController = PlaylistController()
    
    func mockPlaylists() -> [Playlist] {
        let exampleSong = SongController.sharedController.mockData()
        let playlist1 = Playlist(songs:[exampleSong[0], exampleSong[1], exampleSong[2]], name: "Trill Playlist")
        let playlist2 = Playlist(songs: [exampleSong[2], exampleSong[4], exampleSong[0]], name: "nice")
        let playlist3 = Playlist(songs: [exampleSong[3], exampleSong[2], exampleSong[1]], name: "cool playlist")
        
        return [playlist1, playlist2, playlist3]
    }
}