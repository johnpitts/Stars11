//
//  StarsViewController.swift
//  Stars11
//
//  Created by John Pitts on 10/15/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import UIKit

class StarsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    
    var starController = StarController()
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self      // you can also drag this in like an outlet which we did last week
        tableView.delegate = self
        starController.loadFromPersitentStore()
    }

    @IBAction func printButtonTapped(_ sender: Any) {
        print(starController.listStars())
    }
    

    
    
    @IBAction func createButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
            let distanceString = distanceTextField.text,
            !name.isEmpty,
            !distanceString.isEmpty,
            let distance = Double(distanceString) else { return }
        starController.createStar(named: name, withDistance: distance)
        nameTextField.text = ""
        distanceTextField.text = ""
        nameTextField.becomeFirstResponder()    // dismisses the keyboard
        tableView.reloadData()
    }
}


extension StarsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starController.stars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StarCell", for: indexPath) as? StarsTableViewCell else { return UITableViewCell() }
        
        let star = starController.stars[indexPath.row]
        cell.star = star
        return cell
    }
    
    
}

