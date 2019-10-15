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
    
    // 'private (set)var' makes it so that ONLY this class can manipulate the stars data.
    private (set)var stars: [Star] = []
    
    
    //MARK: CRUD ops
    
    // discardable means returned Star is extra and only sometimes used, so you don't have to do let _ = createStar....    to get rid of caution statements.  We didn't need to return Star here, but LS wanted to show the discardableResult feature.
    @discardableResult func createStar(named name: String, withDistance distance: Double) -> Star {
        let newlyCreatedStar = Star(name: name, distance: distance)
        stars.append(newlyCreatedStar)
        return newlyCreatedStar
    }
    
    func updateStar(named name: String, withDistance distance: Double) {
        
    }
    
    
    func deleteStar(named name: String) {
        
    }
    
    
    //MARK: Persistence ops
    
    func saveToPersistentStore() {
        
    }
    
    func loadFromPersitentStore() {
        
    }
    
    
}
