//
//  UserCoreDataModelKeys.swift
//  SmileFiles
//
//  Created by Tyler hostager on 3/28/18.
//  Copyright © 2018 Tyler hostager. All rights reserved.
//

import Foundation
import CoreData


typealias Key = String
typealias ValueForKey = AnyObject?


public enum UserDataAttribute {
    case canChangeTheme
    case current
    case dataDidChange
    case didCompleteOnboarding
    case email
    case files
    case hasCloudFiles
    case hasOfflineFiles
    case isDebug
    case isLoggedIn
    case isVerified
    case nickname
    case preferences
    case selectedTheme
    case shouldSendEmail
    case username
    case uuid
    case none
    
    init?(forKey key: String) {
        switch key {
        case "canChangeTheme":
            self = .canChangeTheme
        case "current":
            self = .current
        case "dataDidChange":
            self = .dataDidChange
        case "didCompleteOnboarding":
            self = .didCompleteOnboarding
        case "email":
            self = .email
        case "files":
            self = .files
        case "hasCloudFiles":
            self = .hasCloudFiles
        case "hasOfflineFiles":
            self = .hasOfflineFiles
        case "isDebug":
            self = .isDebug
        case "isLoggedIn":
            self = .isLoggedIn
        case "isVerified":
            self = .isVerified
        case "nickname":
            self = .nickname
        case "preferences":
            self = .preferences
        case "selectedTheme":
            self = .selectedTheme
        case "shouldSendEmail":
            self = .shouldSendEmail
        case "username":
            self = .username
        case "uuid":
            self = .uuid
        case "none":
            self = .none
        default:
            self = .none
        }
    }
}
