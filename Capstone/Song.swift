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
    var trackURI: NSURL
    
    init(name: String, playCount: Int = 0, artist: Artist, album: Album, albumArtwork: UIImage? = nil, songURL: NSURL? = nil, imageURL: String? = "", trackURI: NSURL) {
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