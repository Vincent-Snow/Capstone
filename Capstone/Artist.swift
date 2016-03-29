//
//  Artist.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation

class Artist {
    
    var name: String
    var albums: [Album]
    
    init(name: String, albums: [Album]) {
        self.name = name
        self.albums = albums
    }
}