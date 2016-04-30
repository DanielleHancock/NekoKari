//
//  PlayerFoundCatViewController.swift
//  NekoKari
//
//  Created by Lisa Sun on 4/15/16.
//  Copyright © 2016 Lisa Sun. All rights reserved.
//

import UIKit

class PlayerFoundCatViewController: UIViewController {
    
   
    @IBOutlet weak var foundCatNameLabel: UILabel!
    
    @IBAction func findMoreCatsButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("foundCatToPlayer", sender: self)
    }
    
    @IBAction func catBookButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("foundCatToCatBook", sender: self)
    }
    
    override func viewDidLoad() {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        foundCatNameLabel.text = "You found a cat!"
    }
    

    
}
