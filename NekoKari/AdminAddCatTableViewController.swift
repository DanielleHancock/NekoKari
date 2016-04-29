//
//  AdminAddCatTableViewController.swift
//  NekoKari
//
//  Created by Lisa Sun on 3/17/16.
//  Copyright © 2016 Lisa Sun. All rights reserved.
//

import UIKit
import Firebase

class AdminAddCatTableViewController: UITableViewController {
    
    let admin = "032adce6-9477-47a7-a763-75b5b3f80663"
    let ref = Firebase(url: "https://nekokari.firebaseio.com")
    
    @IBOutlet weak var snowballGPSLabel: UILabel!
    @IBOutlet weak var smokeyGPSLabel: UILabel!
    @IBOutlet weak var shadowGPSLabel: UILabel!
    @IBOutlet weak var spotsGPSLabel: UILabel!
    @IBOutlet weak var sunnyGPSLabel: UILabel!
    
    var catRefArray: [AnyObject] = []
    
    var coord:String = ""
    
    let shareData = ShareData.sharedInstance
    
    func updateCoord() {
        if let bar = self.shareData.someString {
            self.coord = bar
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red:0.996, green:0.761, blue:0.620, alpha:1.00) //make the background color light blue
        header.textLabel!.textColor = UIColor.whiteColor() //make the text white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "updateCoord", userInfo: nil, repeats: true)
        
        var catNameArray: [AnyObject] = []
        
        catNameArray.append("Snowball")
        catNameArray.append("Smokey")
        catNameArray.append("Shadow")
        catNameArray.append("Spots")
        catNameArray.append("Sunny")
        
        
        for i in 0...4 {
            catRefArray.append(self.ref.childByAppendingPath("admin").childByAppendingPath(self.admin).childByAppendingPath(catNameArray[i] as! String))
        }
    
        catRefArray[0].observeEventType(.Value, withBlock: { snapshot in
            if let value:String = snapshot.value as? String {
                self.snowballGPSLabel.text = value
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
        catRefArray[1].observeEventType(.Value, withBlock: { snapshot in
            if let value:String = snapshot.value as? String {
                self.smokeyGPSLabel.text = value
            }
        }, withCancelBlock: { error in
                print(error.description)
        })
        catRefArray[2].observeEventType(.Value, withBlock: { snapshot in
            if let value:String = snapshot.value as? String {
                self.shadowGPSLabel.text = value
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
        catRefArray[3].observeEventType(.Value, withBlock: { snapshot in
            if let value:String = snapshot.value as? String {
                self.spotsGPSLabel.text = value
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
        catRefArray[4].observeEventType(.Value, withBlock: { snapshot in
            if let value:String = snapshot.value as? String {
                self.sunnyGPSLabel.text = value
            }
            }, withCancelBlock: { error in
                print(error.description)
        })

    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 0) {
            let ref0 = self.ref.childByAppendingPath("admin").childByAppendingPath(self.admin)
            ref0.updateChildValues(["Snowball": self.coord])
         
            
//            ref0.updateChildValues(["Snowball": "36.1335588461261,-80.2766444114201"])
            
        }
        else if (indexPath.row == 1) {
            let ref1 = self.ref.childByAppendingPath("admin").childByAppendingPath(self.admin)
            ref1.updateChildValues(["Smokey": self.coord])
//            ref1.updateChildValues(["Smokey": "42.996501,-89.569232"])

        }
        else if (indexPath.row == 2) {
            let ref2 = self.ref.childByAppendingPath("admin").childByAppendingPath(self.admin)
            ref2.updateChildValues(["Shadow": self.coord])
        }
        else if (indexPath.row == 3) {
            let ref3 = self.ref.childByAppendingPath("admin").childByAppendingPath(self.admin)
            ref3.updateChildValues(["Spots": self.coord])
        }
        else {
            let ref4 = self.ref.childByAppendingPath("admin").childByAppendingPath(self.admin)
            ref4.updateChildValues(["Sunny": self.coord])
        }
    }

}
