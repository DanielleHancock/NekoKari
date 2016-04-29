//
//  PlayerFoundCatViewController.swift
//  NekoKari
//
//  Created by Lisa Sun on 4/15/16.
//  Copyright © 2016 Lisa Sun. All rights reserved.
//

import UIKit

class PlayerFoundCatViewController: UIViewController {

    @IBAction func findMoreCatsButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("foundCatToPlayer", sender: self)
    }
    
    @IBAction func catBookButtonDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("foundCatToCatBook", sender: self)
    }
    
}
