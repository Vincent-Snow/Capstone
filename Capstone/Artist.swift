//
//  Artist.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation

class Artist: Hashable {
    
    var name: String
    var albums: [Album]?
    var hashValue: Int {
        return 0
    }
    
    init(name: String, albums: [Album]? = []) {
        self.name = name
        self.albums = albums
    }
}
func ==(lhs: Artist, rhs: Artist) -> Bool {
    return lhs.name == rhs.name
}