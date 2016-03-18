//
//  ShareData.swift
//  NekoKari
//
//  Created by Lisa Sun on 3/17/16.
//  Copyright © 2016 Lisa Sun. All rights reserved.
//

import Foundation

class ShareData {
    class var sharedInstance: ShareData {
        struct Static {
            static var instance: ShareData?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = ShareData()
        }
        
        return Static.instance!
    }
    
    
    var someString : String! //Some String
    
    var selectedTheme : AnyObject! //Some Object
    
    var someBoolValue : Bool!
    
}