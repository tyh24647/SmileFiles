//
//  SFPreferences+CoreDataProperties.swift
//  SmileFiles
//
//  Created by Tyler hostager on 3/28/18.
//  Copyright © 2018 Tyler hostager. All rights reserved.
//
//

import Foundation
import CoreData


extension SFPreferences {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SFPreferences> {
        return NSFetchRequest<SFPreferences>(entityName: "SFPreferences")
    }

    @NSManaged public var browserEnabled: Bool
    @NSManaged public var useExternalBrowser: Bool
    @NSManaged public var useInAppSafari: Bool

}
