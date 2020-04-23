//
//  InputViewController.swift
//  Schoene Orte
//
//  Created by Sebastian Rieger on 22.04.20.
//  Copyright © 2020 Sebastian Rieger. All rights reserved.
//

import UIKit

protocol InputViewControllerDelegate: class {
    
    func inputViewControllerDidCancel(_ inputViewController: InputViewController)
    func inputViewControllerDidFinish(_ inputViewController: InputViewController)
}

class InputViewController: UITableViewController, UIAdaptivePresentationControllerDelegate {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var websiteTextfield: UITextField!
    @IBOutlet weak var phonenumberTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func cancle(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Delegate
    
    weak var delegate: InputViewControllerDelegate?
    
    func sendDidCancel() {
        delegate?.inputViewControllerDidCancel(self)
    }
    
    func sendDidFinish() {
        delegate?.inputViewControllerDidFinish(self)
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        print("diddissmis")
        
    }
    
    @IBAction func save(_ sender: Any) {
        
        if let name = nameTextfield.text{
            let place = Place(name: name, website: websiteTextfield.text, phone: phonenumberTextfield.text)
            print("place: \(place)")
            let plistDictionary = place.plistDictionary()
            print("plistDictionary: \(plistDictionary)")
            
            let plistArry = [plistDictionary]
            do {
                let data = try PropertyListSerialization.data(fromPropertyList: plistArry, format: .xml, options: 0)
                
                let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                
                if let documentURL = fileURLs.first {
                    let url = documentURL.appendingPathComponent("places.plist")
                    try data.write(to: url, options: .atomic)
                    
//                    presentationControllerDidDismiss(self.presentingViewController!.presentationController!)
//                    let blub = self.presentingViewController as! UIAdaptivePresentationControllerDelegate
//                    blub.presentationControllerDidDismiss()
//                    dismiss(animated: true, completion: nil)
                    sendDidFinish()
                    dismiss(animated: true, completion: nil)
                } else {
                    print("Fehler im Dateisystem")
                }
            } catch {
                print("error: \(error)")
            }
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
