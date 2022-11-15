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
        saveToPersistenceStore()
    }
    
    
    //    Delete
    func deleteSong(song: Song) {
        guard let index = songs.firstIndex(of: song) else { return }
        songs.remove(at: index)
        saveToPersistenceStore()
    }
    
    //  MARK: - Persistence

    //  Persistence Store
    func persistentStore() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Playlist.json")
        return fileURL
    }

    //  Save
    func saveToPersistenceStore(){
        do {
            let data = try JSONEncoder().encode(songs)
            try data.write(to: persistentStore())
        } catch {
            print("We had an error saving to our persistence store.")
            print(error)
            print(error.localizedDescription)
        }
    }
    //  Load
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: persistentStore())
            songs = try JSONDecoder().decode([Song].self, from: data)
        } catch {
            print("We had an error loading our data from the persistence store.")
            print(error)
            print(error.localizedDescription)
        }
    }
}
