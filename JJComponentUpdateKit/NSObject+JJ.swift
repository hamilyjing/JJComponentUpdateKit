//
//  NSObject+JJ.swift
//  JJComponentUpdateKit
//
//  Created by JJ on 11/1/15.
//  Copyright © 2015 JJ. All rights reserved.
//

import Foundation

extension NSObject
{
    class func jj_classFromString(className: String) -> AnyClass?
    {
        if let appName: String? = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String?
        {
            let swiftClassName = "_TtC\(appName!.utf16.count)\(appName!)\(className.utf16.count)\(className)"
            let resultClass: AnyClass? = NSClassFromString(swiftClassName)
            return resultClass
        }
        
        return nil
    }
}