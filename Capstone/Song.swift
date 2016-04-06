//
//  Song.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation
import UIKit

class Song {
    
    var name: String
    var playCount: Int
    var artist: Artist
    var album: Album
    var albumArtwork: UIImage?
    var songURL: NSURL?
    var imageURL: String?
    var trackURI: String
    
    init(name: String, playCount: Int, artist: Artist, album: Album, albumArtwork: UIImage? = nil, songURL: NSURL? = nil, imageURL: String? = "", trackURI: String) {
        self.name = name
        self.playCount = playCount
        self.artist = artist
        self.album = album
        self.albumArtwork = albumArtwork
        self.songURL = songURL
        self.imageURL = imageURL
        self.trackURI = trackURI
    }
}