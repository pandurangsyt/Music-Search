//
//  Album.swift
//  Music Search
//
//  Created by Pandu on 2/22/17.
//  Copyright © 2017 Pandurang Yachwad. All rights reserved.
//
// FUTURE - All potential improvement changes are commented with FUTURE

import UIKit

class Album: NSObject {
    
    var trackName:String!
    var artistName:String!
    var albumName:String!
    var albumImageURL:String!
    
    init (trackName: String, artistName: String, albumName: String, albumImageURL: String){
        super.init()
        self.trackName = trackName
        self.artistName = artistName
        self.albumName = albumName
        self.albumImageURL = albumImageURL
    }
}
