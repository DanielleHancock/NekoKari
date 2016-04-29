//
//  PlayerFoundCatViewController.swift
//  NekoKari
//
//  Created by Lisa Sun on 4/15/16.
//  Copyright © 2016 Lisa Sun. All rights reserved.
//

import UIKit
import Firebase

class PlayerFoundCatViewController: UIViewController, PlayerQRCodeViewControllerDelegate {
    
    var userid = ""
    let ref = Firebase(url: "https://nekokari.firebaseio.com")

    @IBOutlet weak var foundCatNameLabel: UILabel!
    
    @IBAction func findMoreCatsButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("foundCatToPlayer", sender: self)
    }
    
    @IBAction func catBookButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("foundCatToCatBook", sender: self)
    }
    
    override func viewDidLoad() {
        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                self.userid = authData.uid
                print("uid" + self.userid)
            } else {
                // No user is signed in
            }
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        self.ref.childByAppendingPath("users").childByAppendingPath(self.userid).setValue(["Snowball":false, "Smokey":false, "Spots":false, "Shadow":false, "Sunny": false])
    }
    
    func foundCatName(sender: PlayerQRCodeViewController, catName: String) {
        foundCatNameLabel.text = "You found: " + catName
        self.ref.childByAppendingPath("users").childByAppendingPath(self.userid).setValue([catName:true])
    }
    
}
