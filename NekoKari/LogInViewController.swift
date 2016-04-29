//
//  LogInViewController.swift
//  NekoKari
//
//  Created by Lisa Sun on 3/16/16.
//  Copyright © 2016 Lisa Sun. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    let ref = Firebase(url: "https://nekokari.firebaseio.com")
    let admin = "032adce6-9477-47a7-a763-75b5b3f80663"
   
    @IBOutlet weak var emailField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    
   
    @IBAction func logInDidTouch(sender: AnyObject)
    {
        self.ref.authUser(self.emailField.text, password: self.passwordField.text,
            withCompletionBlock: { error, authData in
                if error != nil {
                    // There was an error logging in to this account
                    let logInAlertController = UIAlertController(title: "Error", message:
                        "Wrong Username or Password", preferredStyle: UIAlertControllerStyle.Alert)
                    logInAlertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(logInAlertController, animated: true, completion: nil)
                }
                else {
                    //logged in
                    if (authData.uid == self.admin) {
                        self.performSegueWithIdentifier("adminScreen", sender: self)
                    }
                    else {
                        self.performSegueWithIdentifier("playerScreen", sender: self)
                    }
                    
                }
        })
    }


    @IBAction func signUpDidTouch(sender: AnyObject)
    {
        self.ref.createUser(self.emailField.text, password: self.passwordField.text) { (error: NSError!) in
            if error == nil {
                self.ref.authUser(self.emailField.text, password: self.passwordField.text,
                    withCompletionBlock: { error, authData in
                        if error != nil {
                            // There was an error logging in to this account
                            print("hello")
//                            let alertController = UIAlertController(title: "Error", message:
//                                "Existing Account", preferredStyle: UIAlertControllerStyle.Alert)
//                            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//                            
//                            self.presentViewController(alertController, animated: true, completion: nil)
                        } else {
                            //logged in
                            self.ref.childByAppendingPath("users").childByAppendingPath(authData.uid).setValue(["Snowball":false, "Smokey":false, "Spots":false, "Shadow":false, "Sunny": false])
                            self.performSegueWithIdentifier("playerScreen", sender: self)
                            
                        }
                })
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

