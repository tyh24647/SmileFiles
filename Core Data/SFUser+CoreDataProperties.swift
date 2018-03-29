//
//  SFUser+CoreDataProperties.swift
//  SmileFiles
//
//  Created by Tyler hostager on 3/28/18.
//  Copyright © 2018 Tyler hostager. All rights reserved.
//
//

import Foundation
import CoreData


extension SFUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SFUser> {
        return NSFetchRequest<SFUser>(entityName: "SFUser")
    }

    @NSManaged public var canChangeTheme: Bool
    @NSManaged public var dataDidChange: Bool
    @NSManaged public var didCompleteOnboarding: Bool
    @NSManaged public var email: String?
    @NSManaged public var files: NSObject?
    @NSManaged public var hasCloudFiles: Bool
    @NSManaged public var hasFiles: Bool
    @NSManaged public var hasOfflineFiles: Bool
    @NSManaged public var isDebug: Bool
    @NSManaged public var isLoggedIn: Bool
    @NSManaged public var isVerified: Bool
    @NSManaged public var nickname: String?
    @NSManaged public var preferences: NSObject?
    @NSManaged public var selectedTheme: NSObject?
    @NSManaged public var shouldSendEmail: Bool
    @NSManaged public var username: String?
    @NSManaged public var uuid: UUID?
}
