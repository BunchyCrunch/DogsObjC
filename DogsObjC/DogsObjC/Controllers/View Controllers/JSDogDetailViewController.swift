//
//  JSDogDetailViewController.swift
//  DogsObjC
//
//  Created by Josh Sparks on 10/10/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

import UIKit

class JSDogDetailViewController: UIViewController {
    
    @IBOutlet weak var dogImageView: UIImageView!
    
    var receiver: JSDog?
    var subreceiver: JSSubDog?
    var breedName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateViews()
    }
    
    func updateViews() {
        if let subreceiver = subreceiver {
            guard let breedName = breedName else { return }
            JSDogController.shared().fetchSubDogImageURL(subreceiver, breedName: breedName) { (url) in
                if let url = url {
                    JSDogController.shared().fetchImageSubDog(url) { (image) in
                        DispatchQueue.main.async {
                            self.dogImageView.image = image
                        }
                    }
                }
            }
            
        } else if let receiver = receiver {
            JSDogController.shared().fetchImageURL(receiver) { (url) in
                if let url = url {
                    JSDogController.shared().fetchImage(url) { (image) in
                        DispatchQueue.main.async {
                            self.dogImageView.image = image
                        }
                    }
                }
            }
        }
    }
    
}
