//
//  NicePlacesTableViewController.swift
//  Schoene Orte
//
//  Created by Sebastian Rieger on 18.04.20.
//  Copyright © 2020 Sebastian Rieger. All rights reserved.
//

import UIKit

class NicePlacesTableViewController: UITableViewController, InputViewControllerDelegate {
    
    func inputViewControllerDidCancel(_ inputViewController: InputViewController) {
        loadData()
    }
    
    func inputViewControllerDidFinish(_ inputViewController: InputViewController) {
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            // Get the presented navigationController and the editViewController it contains
            let navigationController = segue.destination as! UINavigationController
            let editViewController = navigationController.topViewController as! InputViewController
            
            // Set the editViewController to be the delegate of the presentationController for this presentation,
            // so that editViewController can respond to attempted dismissals
            navigationController.presentationController?.delegate = editViewController
            
            // Set ourself as the delegate of editViewController, so we can respond to editViewController cancelling or finishing
            editViewController.delegate = self
        
    }
    

    var places:[Place] = []

    override func viewDidLoad() {
        print("didload")
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    print("Will Appear")
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    func loadData() {
        places.removeAll()
        
        do {
            let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            
            if let documentURL = fileURLs.first {
                let url = documentURL.appendingPathComponent("places.plist")
                let data = try Data(contentsOf: url)
                let plist = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
                
                if let array = plist as? [[String:Any]] {
                    for dictionary in array {
                        let place = Place(dictionary: dictionary)
                        places.append(place)
                    }
                    tableView.reloadData()
                }
            } else {
                print("Fehler im Dateisystem")
            }
        } catch {
            print("error: \(error)")
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
