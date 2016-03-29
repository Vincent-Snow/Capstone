//
//  SongController.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation
import UIKit

class SongController {
    
    
    
    static func mockData() -> [Song]{
        let song1 = Song(name: "Fat Lip", playCount: 0, artist: Artist(name: "Sum 41") , album: Album(name: "All Killer, No Filler", artist: Artist(name: "Sum 41")), trackURI: "spotify:track:4KacUpvbA3Mfo05gttTjhN")
        let song2 = Song(name: "In Too Deep", playCount: 0, artist: Artist(name: "Sum 41"), album: Album(name: "All Killer, No Filler", artist: Artist(name: "Sum 41")), trackURI: "spotify:track:1HNE2PX70ztbEl6MLxrpNL")
        let song3 = Song(name: "Ocean Avenue", playCount: 0, artist: Artist(name: "Yellowcard"), album: Album(name: "Ocean Avenue",artist: Artist(name: "Yellowcard")), trackURI: "spotify:track:23oxJmDc1V9uLUSmN2LIvx")
        let song4 = Song(name: "Nerve", playCount: 0, artist: Artist(name: "The Story So Far"), album: Album(name: "The Story So Far", artist: Artist(name: "The Story So Far")), trackURI: "spotify:track:1DlT3Udf11689ezYr6R8aA")
        let song5 = Song(name: "The Things I Can't Change", playCount: 0, artist: Artist(name: "The Story So Far"), album: Album(name: "The Story So Far", artist: Artist(name: "The Story So Far")), trackURI: "spotify:track:0a96MZrTDKwvl1MTYvDP3o")
        return [song1, song2, song3, song4, song5]
    }
    
    
}