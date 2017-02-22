//
//  iTuneConnection.swift
//  Music Search
//
//  Created by Pandu on 2/22/17.
//  Copyright © 2017 Pandurang Yachwad. All rights reserved.
//
// FUTURE - All potential improvement changes are commented with FUTURE

import UIKit

class iTuneConnection: NSObject {
    
    class func getAlbumForString(searchString:String, completionHandler:@escaping (Album)->()) {

        let escapedString = searchString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
        let url = NSURL(string: "https://itunes.apple.com/search?term=\(escapedString!)")
        let task = URLSession.shared.dataTask(with: url as! URL) { (data, response, error) in
            if error != nil{
                print("Error")
// FUTURE - This can be handled with message to user about the error
            } else{
                if let urlContent = data{
                    do {
                        let iTunesDict = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        let resultsArray = iTunesDict.object(forKey: "results") as! [Dictionary<String,AnyObject>]
                        
                        if resultsArray.count > 0 {
                            for resultsDict in resultsArray{
                                var artistName = resultsDict["artistName"] as? String
                                if artistName == nil{
                                    artistNames.append(" ")
                                    artistName = " "
                                } else{
                                    artistNames.append(artistName!)
                                }
                                var albumImageURL = resultsDict["artworkUrl100"] as? String
                                if albumImageURL == nil{
                                    albumImageUrls.append(" ")
                                    albumImageURL = " "
                                } else{
                                    albumImageUrls.append(albumImageURL!)
                                }

                                var trackName = resultsDict["trackName"] as? String
                                if trackName == nil{
                                    trackNames.append(" ")
                                    trackName = " "
                                } else{
                                    trackNames.append(trackName!)
                                }
                                
                                var albumName = resultsDict["collectionName"] as? String
                                if albumName == nil{
                                    albumNames.append(" ")
                                    albumName = " "
                                } else{
                                    albumNames.append(albumName!)
                                }
// FUTURE - Add data validation for all JSON objects being used and have default values
                                
                                let album = Album(trackName: trackName!, artistName: artistName!, albumName: albumName!, albumImageURL: albumImageURL!)
                                completionHandler(album)
                            }
                        }
                    } catch{
// FUTURE - This can be handled with message to user about the error                        
                         print("JSON Processing Failed")
                    }
                }
            }
        }
        task.resume()
    }
}
