//
//  ManagedObjectContext.swift
//  SmileFiles
//
//  Created by Tyler hostager on 3/28/18.
//  Copyright © 2018 Tyler hostager. All rights reserved.
//

import Foundation
import CoreData

public class ManagedObjectContext: NSManagedObjectContext {
    
    
    public static var current: NSManagedObjectContext! {
        get {
            return { () -> NSManagedObjectContext in
                return SFSharedData.instance!.managedObjectContext
            }()
        }
    }
    
    
}
