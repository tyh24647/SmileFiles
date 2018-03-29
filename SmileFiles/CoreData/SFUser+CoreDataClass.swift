//
//  SFUser+CoreDataClass.swift
//  SmileFiles
//
//  Created by Tyler hostager on 3/28/18.
//  Copyright © 2018 Tyler hostager. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SFUser)
public class SFUser: NSManagedObject {
    
    public static var current: SFUser! {
        get {
            return { () -> SFUser in
                return SFSharedData.user ?? { () -> SFUser in
                    let tmpUser = SFUser()
                    tmpUser.username = "TESTT!!! TMP DELETE MEH PLZ!!!"
                    tmpUser.email = "tyh24647@gmail.com"
                    tmpUser.isDebug = true
                    return tmpUser
                }()
            }()
        }
    }
}
