//
//  JSDogTableViewController.swift
//  DogsObjC
//
//  Created by Josh Sparks on 10/10/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

import UIKit

class JSDogTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JSDogController.shared().fetchDogs { (true) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return JSDogController.shared().dogs.count
    }
    
    // When you click on a dog, if there is a subBreed, use the segue that takes you to the table list view for the subBreeds. Otherwise, take you to the image view.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breed = JSDogController.shared().dogs[indexPath.row]
        guard let subBreedCount = breed.subBreed?.count else { return }
        if subBreedCount > 0 {
            performSegue(withIdentifier: "toSubDog", sender: Any?.self)
        } else {
            performSegue(withIdentifier: "toImage", sender: Any?.self)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dogCell", for: indexPath)
        
        let dog = JSDogController.shared().dogs[indexPath.row]
        
        cell.textLabel?.text = dog.breed
        
        return cell
    }
    
    // MARK: - Navigation
    
    // These segues take you to a different ViewControllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImage" {
            guard let destinationVC = segue.destination as? JSDogDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let objectToSend = JSDogController.shared().dogs[indexPath.row]
            destinationVC.receiver = objectToSend
        } else if segue.identifier == "toSubDog" {
            guard let destinationVC = segue.destination as? JSSubDogTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let objectToSend = JSDogController.shared().dogs[indexPath.row]
            destinationVC.dogLanding = objectToSend
        }
    }
    
    
}
