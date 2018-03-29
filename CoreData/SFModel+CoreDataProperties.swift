//
//  SFModel+CoreDataProperties.swift
//  SmileFiles
//
//  Created by Tyler hostager on 3/28/18.
//  Copyright © 2018 Tyler hostager. All rights reserved.
//
//

import Foundation
import CoreData


extension SFModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SFModel> {
        return NSFetchRequest<SFModel>(entityName: "SFModel")
    }

    @NSManaged public var users: NSObject?

}
