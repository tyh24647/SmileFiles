//
//  SFTheme+CoreDataProperties.swift
//  SmileFiles
//
//  Created by Tyler hostager on 3/28/18.
//  Copyright © 2018 Tyler hostager. All rights reserved.
//
//

import Foundation
import CoreData


extension SFTheme {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SFTheme> {
        return NSFetchRequest<SFTheme>(entityName: "SFTheme")
    }

    @NSManaged public var name: String?

}
