//
//  Playlist.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation

class Playlist {
    
    var songs: [Song]
    var name: String
    
    init(songs: [Song], name: String) {
        self.songs = songs
        self.name = name
    }
}