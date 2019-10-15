//
//  StarController.swift
//  Stars11
//
//  Created by John Pitts on 10/15/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import Foundation

// the viewcontroller's job is simply to display a view, not manipulate data/model, so this is why we have a modelController (starController) to do all the heavy lifting with the data
class StarController {
    
    init() {
        loadFromPersitentStore()
    }
    
    // 'private (set)var' makes it so that ONLY this class can manipulate the stars data.
    private (set)var stars: [Star] = []
    
    private var persistentURL: URL? {
        let fileManager = FileManager.default
        // documentsDirectory is sectioned off for each app, but ONLY the app. It's an array of directories, hence we need to use .first
        
        //  the documents directory for the app looks like this..... file:///Users/johnpitts/Library/Developer/CoreSimulator/Devices/4861BEEB-CBBE-4809-820C-0C3C84233F44/data/Containers/Data/Application/CA2AF033-F5ED-447E-BAE5-8B8FBF4D1DEF/Documents/
        
        // .userDomainMask is a way to "filter it down"
        // must be unwrapped bc .first could be nil, it's asking for a url in an array of URLs
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }

        return directory.appendingPathComponent("stars.plist")
    }
    
    
    //MARK: CRUD ops
    
    // discardable means returned Star is extra and only sometimes used, so you don't have to do let _ = createStar....    to get rid of caution statements.  We didn't need to return Star here, but LS wanted to show the discardableResult feature.
    @discardableResult func createStar(named name: String, withDistance distance: Double) -> Star {
        let newlyCreatedStar = Star(name: name, distance: distance)
        stars.append(newlyCreatedStar)
        saveToPersistentStore()
        return newlyCreatedStar
    }
    
    func listStars() -> String {
        var output = ""
        for star in stars {
            output += "\(star.name) is \(String(star.distanceDescription)). \n"
        }
        return output
    }

    
    
    //MARK: Persistence ops
    
    func saveToPersistentStore() {
        guard let url = persistentURL else { return }
        do {
            let encoder = PropertyListEncoder()      // get instance of a encoder
            let data = try encoder.encode(stars)     // encode stars into FileManager language (JSON? XML?)
            try data.write(to: url)                // take encoded data and write it to the url in FileManager
        } catch {
            NSLog("Error writing stars array to persistent store: \(error)")
        }
    }
    
    func loadFromPersitentStore() {                      // Our persistent Store is going to be a PropertyList with it's own url (associated with the app, see computed persistentURL property)
        let fm = FileManager.default                            // get instance of FileManager
        guard let url = persistentURL,
            fm.fileExists(atPath: url.path) else { return }     // check to see if anything is stored there
        do {
            let data = try Data(contentsOf: url)                // grab the data from the url in FileMgr
            let decoder = PropertyListDecoder()                 // get instance of decoder so you can decode
            stars = try decoder.decode([Star].self, from: data)  // decode data to your model type and save as that model's instance "stars" which is a class property, remember, thus full scope in this file
        } catch {                                                // if either of the two 'trys' fails, catch the error....
            NSLog("error getting data from persistent store \(error)")
        }
        
    }
    
    
}
