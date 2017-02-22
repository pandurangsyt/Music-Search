//
//  wikiConnection.swift
//  Music Search
//
//  Created by Pandu on 2/22/17.
//  Copyright © 2017 Pandurang Yachwad. All rights reserved.
//
// FUTURE - All potential improvement changes are commented with FUTURE

import UIKit

class wikiConnection: NSObject {
    class func getLyricsForSong(songName: String, artistName: String, completionHandler:@escaping (Lyrics) -> ()){
        let escapedSongNameString = songName.replacingOccurrences(of: " ", with: "+")
        let escapedArtistNameString = artistName.replacingOccurrences(of: " ", with: "+")
        let url = "http://lyrics.wikia.com/api.php?func=getSong&artist=\(escapedArtistNameString)&song=\(escapedSongNameString)&fmt=json"
        guard let myURL = URL(string: url) else {
            print("Error: \(url) doesn't seem to be a valid URL")
            return
        }
// Comment - As API output was not in JSON, did workaround to read the content and parse the lyrics using String manupulation
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            let beforeLyricsString = myHTMLString.components(separatedBy: "'lyrics':'")
            let afterLyricsString = beforeLyricsString[1].components(separatedBy: "'url':'")
            var lyricsString = String(afterLyricsString[0].characters.dropLast(3))
            lyricsString = lyricsString.replacingOccurrences(of: "\\n", with: ". ")
            lyricsString = lyricsString.replacingOccurrences(of: "\\'", with: "'")
            let lyrics = Lyrics(lyrics: lyricsString)
            completionHandler(lyrics)
        } catch let error {
            print("Error: \(error)")
        }
// FUTURE - Lyrics Wikia API is not JSON so had to parse the output string and display the lyrics. Other public API for lyrics can be used for better performance and wider range of lyrics
        
/*        let task = URLSession.shared.dataTask(with: url as! URL) { (data, response, error) in
            if error != nil{
                print("Error")
// FUTURE - Handle error systematic way
            } else{
                if let urlContent = data{
                    do {
                        let wikiDictionary = JSONSerialization.isValidJSONObject(urlContent)
         
                        let wikiDict2 = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.allowFragments)
                        let wikiDict = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        let resultsArray = wikiDict.object(forKey: "song") as! [Dictionary<String,AnyObject>]
                        if resultsArray.count > 0 {
                            
                            if let resultsDict = resultsArray.first{
                                let songLyrics = resultsDict["lyrics"] as! String
                                let lyrics = Lyrics(lyrics: songLyrics)
                                completionHandler(lyrics)
                            }
                        }
                    }
                    catch{
                        print(error)
                        print("JSON Processing Failed")
                    }
                }
            }
        }
        task.resume()
 */
    }       
}
