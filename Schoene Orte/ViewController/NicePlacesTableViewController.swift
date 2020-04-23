//
//  NicePlacesTableViewController.swift
//  Schoene Orte
//
//  Created by Sebastian Rieger on 18.04.20.
//  Copyright © 2020 Sebastian Rieger. All rights reserved.
//

import UIKit
import os

class NicePlacesTableViewController: UITableViewController, InputViewControllerDelegate {
    
    // MARK: - DELEGATE
    
    func inputViewControllerDidCancel(_ inputViewController: InputViewController) {
        loadData()
    }
    
    func inputViewControllerDidFinish(_ inputViewController: InputViewController) {
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        // Get the presented navigationController and the inputViewController it contains
        let navigationController = segue.destination as! UINavigationController
        let inputViewController = navigationController.topViewController as! InputViewController
            
        // Set the editViewController to be the delegate of the presentationController for this presentation,
        // so that editViewController can respond to attempted dismissals
        navigationController.presentationController?.delegate = inputViewController
            
        // Set ourself as the delegate of editViewController, so we can respond to editViewController cancelling or finishing
        inputViewController.delegate = self
        
    }
    
    // MARK: - MODEL
    
    var places:[Place] = []
    
    // MARK: - VIEW

    override func viewDidLoad() {

        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    func loadData() {
        places.removeAll()
        
        do {
            let data = try Data(contentsOf: try FileHandler.placesURL())
            let plist = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
                
            if let array = plist as? [[String:Any]] {
                for dictionary in array {
                    let place = Place(dictionary: dictionary)
                    places.append(place)
            }
                tableView.reloadData()
            }
        } catch {
            os_log("Could not read data", type: .info)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let place = places[indexPath.row]
        cell.textLabel?.text = place.name
        cell.detailTextLabel?.text = "\(place.timestamp)"

        return cell
    }
}
