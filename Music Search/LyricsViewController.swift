//
//  LyricsViewController.swift
//  Music Search
//
//  Created by Pandu on 2/22/17.
//  Copyright © 2017 Pandurang Yachwad. All rights reserved.
//

import UIKit

class LyricsViewController: UIViewController {

    @IBOutlet var albumImageView: UIImageView!
    @IBOutlet var trackNameLabel: UILabel!
    @IBOutlet var albumNameLabel: UILabel!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var lyricsLabel: UILabel!
        
    var artistName: String = ""
    var albumName: String = ""
    var albumImageURL: String = ""
    var trackName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: albumImageURL)!
        let imageData = NSData(contentsOf: url)!
        albumImageView.image = UIImage(data: imageData as Data)
        albumNameLabel.text = albumName
        trackNameLabel.text = trackName
        artistNameLabel.text = artistName

        wikiConnection.getLyricsForSong(songName: trackName, artistName: artistName) { (lyrics) in
            print(lyrics)
            print(lyrics.lyrics)
//            dispatchMain()
            self.lyricsLabel.text = lyrics.lyrics
//            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//            self.loadView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
