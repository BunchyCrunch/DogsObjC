//
//  JSSubDogTableViewController.swift
//  DogsObjC
//
//  Created by Josh Sparks on 10/10/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

import UIKit

class JSSubDogTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    var dogLanding: JSDog?
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let subDog = self.dogLanding?.subBreed?.count else { return 0 }
        return subDog
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subDogCell", for: indexPath)
        
        guard let dog = self.dogLanding?.subBreed?[indexPath.row] else { return UITableViewCell()}
        
        let name = dog.name
        
        cell.textLabel?.text = name
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subBreedToImage" {
            guard let indexPath = tableView.indexPathForSelectedRow,
            let destinationVC = segue.destination as? JSDogDetailViewController else { return }
            let objectToSend = dogLanding?.subBreed?[indexPath.row]
            let dogName = dogLanding?.breed
            destinationVC.subreceiver = objectToSend
            destinationVC.breedName = dogName
        }
    }
    
    
}
