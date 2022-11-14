//
//  SongTableViewController.swift
//  Playlist
//
//  Created by Nicolas Garaycochea on 11/14/22.
//

import UIKit

class SongTableViewController: UITableViewController {
    
    @IBOutlet var songTitleTextField: UITextField!
    @IBOutlet var artistNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addSongButtonTapped(_ sender: Any) {
//        You have to guard let because title: string cant take an optional string, it has to be just a string so when you place guard let and then else {return} it gives the option to bail on the function. this will also check if its not empty, if it is empty it'll bail on the function and not pass. so it has four condtions, the title, the artist have to have a string in it, and the fields cannot be empty
        guard let songTitle = songTitleTextField.text,
              let artistName = artistNameTextField.text,
              !songTitle.isEmpty,
              !artistName.isEmpty else { return }
        SongController.shared.createSong(title: songTitle, artistName: artistName)
        songTitleTextField.text = ""
        artistNameTextField.text = ""
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SongController.shared.songs.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)

        let song = SongController.shared.songs[indexPath.row]
        
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artistName

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let songToDelete = SongController.shared.songs[indexPath.row]
            SongController.shared.deleteSong(song: songToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }


    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
