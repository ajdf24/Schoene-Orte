//
//  InputViewController.swift
//  Schoene Orte
//
//  Created by Sebastian Rieger on 22.04.20.
//  Copyright © 2020 Sebastian Rieger. All rights reserved.
//

import UIKit

class InputViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
