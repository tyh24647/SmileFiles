//
//  KeyValuePair.swift
//  SmileFiles
//
//  Created by Tyler hostager on 3/28/18.
//  Copyright © 2018 Tyler hostager. All rights reserved.
//

import Foundation

public struct KeyValuePair {
    
    public var isBoolean: Bool! = false
    
    private var _key: String!
    public private(set) var key: String! {
        get { return _key ?? String() }
        set { _key = newValue ?? _key ?? String() }
    }
    
//    private var _boolValue: Bool!
//    public private(set) var boolValue: Bool! {
//        get { return _boolValue ?? Bool() }
//        set { _boolValue = newValue ?? _boolValue ?? Bool() }
//    }
    
    private var _value: Any!
    public private(set) var value: Any! {
        get { return _value ?? NSObject() }
        set { _value = newValue ?? _value ?? NSObject() }
    }
    
    init() {
        self.isBoolean = false
        self.key = "default"
        //self.boolValue = false
        self.value = NSObject()
    }
    
    init(value: Any!, forKey key: String!) {
        if value != nil && key != nil {
            self.isBoolean = false
            self.key = key
            //self.boolValue = false
            self.value = value
        }
    }
    
    
//    init(boolValue: Bool!, forKey key: String!) {
//        if boolValue != nil && key != nil {
//            self.isBoolean = true
//            self.key = key
//            self.boolValue = boolValue
//            self.value = NSObject()
//        }
//    }
    
}
