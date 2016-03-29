//
//  Album.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation

class Album {
    
    var name: String
   var artist: Artist
    
    init(name: String, artist: Artist) {
    self.name = name
       self.artist = artist
        
    }
}