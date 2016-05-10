//
//  Playlist.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation

class Playlist {
    
    var uri: NSURL?
    var name: String
    
    init(uri: NSURL?, name: String) {
        self.uri = uri
        self.name = name
    }
}