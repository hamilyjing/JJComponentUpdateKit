//
//  JJCUKFunctionChangeLabelText.swift
//  JJComponentUpdateKit
//
//  Created by JJ on 11/1/15.
//  Copyright © 2015 JJ. All rights reserved.
//

import Foundation

let ChangeLabelTextNotificationName = "ChangeLabelTextNotificationName"

//@objc(JJCUKFunctionChangeLabelText)
class JJCUKFunctionChangeLabelText: JJCUKHashTableComponentsFunction
{
    var pos = 1
    
    override init()
    {
        super.init()
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(JJCUKFunctionChangeLabelText.changeLabelTextNotification), name: ChangeLabelTextNotificationName, object: nil)
    }
    
    override func updateComponent(component: JJCUKComponentDataSource!, withObject object: AnyObject!)
    {
        let label = component as! UILabel;
        label.text = String(pos)
    }
    
    func changeLabelTextNotification()
    {
        pos += 1
        updateAllComponentWithObject(nil)
    }
}