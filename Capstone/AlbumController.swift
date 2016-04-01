//
//  AlbumController.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation

class AlbumController {
 
    static var sharedAlbumController = AlbumController()
    
    func mockAlbums() -> [Album] {
        let album1 = Album(name: "All Killer, No Filler", artist: Artist(name: "Sum 41"))
        let album2 = Album(name: "Ocean Avenue", artist: Artist(name: "Yellowcard"))
        let album3 = Album(name: "The Story So Far", artist: Artist(name: "The Story So Far"))
        
        return [album1, album2, album3]
    }
    
    
}