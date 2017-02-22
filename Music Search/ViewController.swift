//
//  ViewController.swift
//  Music Search
//
//  Created by Pandu on 2/22/17.
//  Copyright © 2017 Pandurang Yachwad. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var selectedIndex = 0
    
    @IBOutlet var searchString: UITextField!
    
    @IBOutlet var searchProgressMessage: UILabel!
    @IBAction func searchMusic(_ sender: Any) {
        searchString.resignFirstResponder()
        
// FUTURE -  add "Loading" activity view while search is being done so user knows search data is being loaded
        
        if (searchString.text?.isEmpty)!{
            
            displayAlert("Error!", Message: "Enter valid song or artist name")
            
        } else{
            resetSearch()
            self.searchProgressMessage.isHidden = false
            iTuneConnection.getAlbumForString(searchString: (searchString.text)!) { (album) in
                self.tableView.isHidden = false
                self.searchProgressMessage.isHidden = true
                self.tableView.reloadData()
// FUTURE -  Option to load more music, right now it's maxed to 50 records. It can be dynamically loaded with more records
                
// FUTURE - Option to add dynamic message if no records found
                
            }
        }
    }
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isHidden = true
        self.searchProgressMessage.isHidden = true
        self.navigationController?.isToolbarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! albumTableViewCell
        if (albumNames.count > 0){
            cell.albumName.text = albumNames[indexPath.row]
            cell.artistName.text = artistNames[indexPath.row]
            cell.trackName.text = trackNames[indexPath.row]
            let url = URL(string: albumImageUrls[indexPath.row])!
            let imageData = NSData(contentsOf: url)!
            cell.albumImage.image = UIImage(data: imageData as Data)
        } else{
            
// FUTURE -  Add custom image or text for user to see and search the music
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! LyricsViewController
        vc.albumName = albumNames[selectedIndex]
        vc.albumImageURL = albumImageUrls[selectedIndex]
        vc.artistName = artistNames[selectedIndex]
        vc.trackName = trackNames[selectedIndex]
    }
    
    func displayAlert(_ Title: String, Message: String){

        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func resetSearch(){
        albumNames.removeAll()
        albumImageUrls.removeAll()
        trackNames.removeAll()
        artistNames.removeAll()
        self.tableView.reloadData()
    }
}

