//
//  Album.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation

class Album: Hashable {
    
    var name: String
    var artist: Artist
   // var songs: [Song]
    var hashValue: Int {
        return 0
    }
    
    init(name: String, artist: Artist) {
        self.name = name
        self.artist = artist
  //      self.songs = songs
    }
}
func ==(lhs: Album, rhs: Album) -> Bool {
    return lhs.name == rhs.name
}