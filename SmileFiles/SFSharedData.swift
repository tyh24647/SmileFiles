//
//  SFSharedData.swift
//  SmileFiles
//
//  Created by Tyler hostager on 3/28/18.
//  Copyright © 2018 Tyler hostager. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public struct SFSharedData {
    
    /*
     private static var _model: SFModel!
     static var model: SFModel! {
     get {
     return _model ?? ({ () -> SFModel in
     var tmpModel: SFModel!
     
     do {
     let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SFModel")
     let result = try ManagedObjectContext.current.fetch(fetchRequest) as! [SFModel]
     
     fetchRequest.returnsObjectsAsFaults = false
     
     if result[0].users != nil {
     tmpModel = result[0]
     }
     } catch {
     let fetchErr = error as NSError
     print(fetchErr)
     }
     
     return tmpModel
     }()
     )
     } set {
     _model = newValue ?? SFModel()
     }
     }
     */
    
    private static var _instance: AppDelegate!
    static var instance: AppDelegate! {
        get {
            return _instance ?? UIApplication.shared.delegate as! AppDelegate
        } set {
            _instance = newValue ?? UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
        }
    }
    
    private static var _user: SFUser! = { () -> SFUser? in
        //return SFSharedData.instance.preloadData() ?
        
        // EXECUTE FETCH REQUEST AFTER LOADING FROM THE SAVED DATA!!!!!!!!!!!!!!!!!!!!
        // TODO TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST change me!
        // TODO TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST change me!
        return nil
        // TODO TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST change me!
        // TODO TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST change me!
        
        
        }() ?? nil
    
    static var user: SFUser! {
        get {
            var usr: SFUser! = nil
            if _user != nil {
                usr = _user
            } else {
                usr = ({ () -> SFUser? in
                    var sfTmpUser: SFUser! = nil
                    if ManagedObjectContext.current != nil {
                        do {
                            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SFUser")
                            let sortDescriptor = NSSortDescriptor(key: "username", ascending: true)
                            
                            fetchRequest.sortDescriptors = [sortDescriptor]
                            fetchRequest.returnsObjectsAsFaults = false
                            
                            
                            ///*
                            let result = try ManagedObjectContext.current.fetch(fetchRequest) as! [SFUser]
                            
                            // test and see if valid user with username
                            if result[0].value(forKey: "username") != nil {
                                sfTmpUser = result[0]
                                return sfTmpUser
                            }
                            //*/
                            /*
                             let result = try mObjContext.fetch(fetchRequest)
                             for data in result as! [NSManagedObject] {
                             NSLog("[SFSharedData] Fetched object data: \"%@", data)
                             }
                             
                             let tmpResult = try mObjContext.fetch(fetchRequest) as! [NSManagedObject]
                             for var i in 0..<tmpResult.count {
                             var test = tmpResult[i] as! SFUser
                             if test.value(forKey: "username") != nil {
                             sfTmpUser = test
                             }
                             
                             */
                            //sfTmpUser = SFUser()
                            
                            // TODO - Get rid of this once you allow username entry!!!
                            
                            
                            /*
                            sfTmpUser.username = "TESSSSSTTTT!!!"
                            
                            print("Initializing test user: \(sfTmpUser)")
                            //return sfTmpUser
                            */
 
                            //usr = sfTmpUser
                            
                            return sfTmpUser ?? _user ?? SFUser()
                        } catch {
                            let fetchError = error as NSError
                            print(fetchError)
                        }
                    }
                    
                    return _user ?? SFUser()
                    }()
                )
                
                instance.saveContext()
                
            }
            
            return usr
        }
        
        set {
            var tmpUser = newValue ?? SFUser()
            
            //tmpUser.username = "TEEEEEEESSSSSSSSTTTTT!!!!!!!"
            
            ///var usr U
            //usr.initWithDefaults()
            
            ///*
            if self.user == nil {
                #if DEBUG
                tmpUser = User.createSFUserCoreDataObj(
                    forUser: User(),
                    usesDefaultValues: true,
                    withCustomValues: { () -> [KeyValuePair] in
                        return [
                            //KeyValuePair(boolValue: false, forKey: "isVerified")
                            KeyValuePair(
                                value: false,
                                forKey: "isVerified"
                            )
                        ]
                }())
                #else
                tmpUser = User.createSFUserCoreDataObj(
                    forUser: User()
                )
                #endif
            }
            //*/
            
            _user = tmpUser
        }
    }
}
