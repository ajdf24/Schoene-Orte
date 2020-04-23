//
//  InputViewController.swift
//  Schoene Orte
//
//  Created by Sebastian Rieger on 22.04.20.
//  Copyright © 2020 Sebastian Rieger. All rights reserved.
//

import UIKit
import os

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
            os_log("place created", type: .debug)
            let plistDictionary = place.plistDictionary()
            os_log("plistDictionary created", type: .debug)
            
            do {
                let url = try FileHandler.placesURL()
                let plist: Any?
                if let inData = try? Data(contentsOf: url) {
                    do {
                        plist = try PropertyListSerialization.propertyList(from: inData, options: [], format: nil)
                    } catch {
                        plist = nil
                        os_log("Could not read data", type: .error)
                    }
                } else {
                    plist = nil
                    os_log("No Data found to load", type: .info)
                }
                
                var plistArry: [[String:Any]] = []
                if let theArray = plist as? [[String:Any]] {
                    plistArry = theArray
                }
                
                plistArry.append(plistDictionary)
                
                let data = try PropertyListSerialization.data(fromPropertyList: plistArry, format: .xml, options: 0)
                try data.write(to: url, options: .atomic)
                
                sendDidFinish()
                dismiss(animated: true, completion: nil)
            } catch {
                os_log("Could not write data", type: .error)
            }
        }
    }
}
