//
//  ViewController.swift
//  StarRating(Practice)
//
//  Created by Dongwoo Pae on 7/1/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func updateValue(_ sender: RatingControl) {
        if sender.value == 1{
            navigationItem.title = "Rating: \(sender.value) star"
        } else {
            navigationItem.title = "Rating: \(sender.value) stars"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Rating: 0star"
    }


}

