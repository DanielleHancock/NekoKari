//
//  PlayerCatBookViewController.swift
//  NekoKari
//
//  Created by Lisa Sun on 4/15/16.
//  Copyright © 2016 Lisa Sun. All rights reserved.
//

import UIKit
import Firebase

class PlayerCatBookViewController: UIViewController {
    
    let userid = "efa6bda0-026a-466e-bdf8-d70f91ab5ac0"
    let ref = Firebase(url: "https://nekokari.firebaseio.com")

   
    @IBOutlet weak var SnowballPic: UIImageView!
    @IBOutlet weak var SnowballText: UITextView!
    @IBOutlet weak var SmokeyPic: UIImageView!
    @IBOutlet weak var SmokeyText: UITextView!
    @IBOutlet weak var ShadowPic: UIImageView!
    @IBOutlet weak var ShadowText: UITextView!
    @IBOutlet weak var SpotsPic: UIImageView!
    @IBOutlet weak var SpotsText: UITextView!
    @IBOutlet weak var SunnyPic: UIImageView!
    @IBOutlet weak var SunnyText: UITextView!
    
    override func viewDidLoad() {
        self.SnowballPic.image=UIImage(named: "Snowball")
        
        ref.childByAppendingPath("users").childByAppendingPath(userid).childByAppendingPath("Snowball").observeEventType(.Value, withBlock: { snapshot in
            if let value:Bool = snapshot.value as? Bool {
                if value {
                    self.SnowballPic.image=UIImage(named: "Snowball")
                    self.SnowballText.text="Snowball"
                }
            }
            }, withCancelBlock: { error in
                print(error.description)
            })
        
        
        ref.childByAppendingPath("users").childByAppendingPath(userid).childByAppendingPath("Smokey").observeEventType(.Value, withBlock: { snapshot in
            if let value:Bool = snapshot.value as? Bool {
                if value {
                    self.SmokeyPic.image=UIImage(named: "Smokey")
                    self.SmokeyText.text="Smokey"
                }
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        ref.childByAppendingPath("users").childByAppendingPath(userid).childByAppendingPath("Shadow").observeEventType(.Value, withBlock: { snapshot in
            if let value:Bool = snapshot.value as? Bool {
                if value {
                    self.ShadowPic.image=UIImage(named: "Shadow")
                    self.ShadowText.text="Shadow"
                }
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        ref.childByAppendingPath("users").childByAppendingPath(userid).childByAppendingPath("Spots").observeEventType(.Value, withBlock: { snapshot in
            if let value:Bool = snapshot.value as? Bool {
                if value {
                    self.SpotsPic.image=UIImage(named: "Spots")
                    self.SpotsText.text="Spots"
                }
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
        
        ref.childByAppendingPath("users").childByAppendingPath(userid).childByAppendingPath("Sunny").observeEventType(.Value, withBlock: { snapshot in
            if let value:Bool = snapshot.value as? Bool {
                if value {
                    self.SunnyPic.image=UIImage(named: "Sunny")
                    self.SunnyText.text="Sunny"
                }
            }
            }, withCancelBlock: { error in
                print(error.description)
        })    }
    
    
}
