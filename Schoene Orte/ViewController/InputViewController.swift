//
//  InputViewController.swift
//  Schoene Orte
//
//  Created by Sebastian Rieger on 22.04.20.
//  Copyright © 2020 Sebastian Rieger. All rights reserved.
//

import UIKit

protocol InputViewControllerDelegate: class {
    
    func inputViewControllerDidFinish(_ inputViewController: InputViewController)
}

class InputViewController: UITableViewController, UIAdaptivePresentationControllerDelegate {
    
    // MARK: - Delegate
    
    weak var delegate: InputViewControllerDelegate?
    
    func sendDidFinish() {
        delegate?.inputViewControllerDidFinish(self)
    }
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        sendDidFinish()
    }
    
    // MARK: VIEW
    
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
}
