//
//  SongController.swift
//  Playlist
//
//  Created by Nicolas Garaycochea on 11/14/22.
//

import Foundation

class SongController {
    
//    Shared Instance
    static let shared = SongController()
    
//    Source of Truth (the main point of data for this application)
    var songs: [Song] = []
    
    
//    CRUD
    
//    Create
    func createSong(title: String, artistName: String) {
        let newSong = Song(title: title, artistName: artistName)
        songs.append(newSong)
    }
    
    
//    Delete
    func deleteSong(song: Song) {
        guard let index = songs.firstIndex(of: song) else { return }
        songs.remove(at: index)
    }
}
