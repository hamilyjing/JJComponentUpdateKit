//
//  ViewController.swift
//  JJComponentUpdateKit
//
//  Created by JJ on 11/1/15.
//  Copyright © 2015 JJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBAction func change(sender: AnyObject)
    {
        let nc = NSNotificationCenter.defaultCenter()
        nc.postNotificationName(ChangeLabelTextNotificationName, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label1.jjCUKFunctionType = JJCUKFunctionTypeChangeLabelText
        label2.jjCUKFunctionType = JJCUKFunctionTypeChangeLabelText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

