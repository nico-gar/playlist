//
//  PlaylistController.swift
//  Playlist
//
//  Created by Nicolas Garaycochea on 11/16/22.
//

import Foundation

class PlaylistController {
    
    static let shared = PlaylistController()
    
//    Source of Truth
    var playlists: [Playlist] = []
    
//    CRUD
//    Create
    func createPlaylist(name: String) {
        let newPlaylist = Playlist(name: name)
        playlists.append(newPlaylist)
        saveToPersistenceStore()
    }
    
//    Delete
    func deletePlaylist(playlist: Playlist) {
        guard let index = playlists.firstIndex(of: playlist) else { return }
        playlists.remove(at: index)
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
            let data = try JSONEncoder().encode(playlists)
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
            playlists = try JSONDecoder().decode([Playlist].self, from: data)
        } catch {
            print("We had an error loading our data from the persistence store.")
            print(error)
            print(error.localizedDescription)
        }
    }
    
}
