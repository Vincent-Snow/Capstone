//
//  ArtistController.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation

class ArtistController {
    
    static var sharedArtistController = ArtistController()
    
    var artists: [Artist] = []
    
    func mockArtists() -> [Artist] {
        let artist1 = Artist(name: "Sum 41")
        let artist2 = Artist(name: "Yellowcard")
        let artist3 = Artist(name: "The Story So Far")
        
        return [artist1, artist2, artist3]
    }
    
}