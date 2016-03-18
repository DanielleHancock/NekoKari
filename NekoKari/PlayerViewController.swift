//
//  PlayerViewController.swift
//  NekoKari
//
//  Created by Lisa Sun on 3/16/16.
//  Copyright © 2016 Lisa Sun. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    @IBAction func logOutDidTouch(sender: AnyObject) {
        performSegueWithIdentifier("playerToLogin", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

}
