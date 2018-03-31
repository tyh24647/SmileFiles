//
//  AppDelegate.swift
//  SmileFiles
//
//  Created by Tyler hostager on 3/28/18.
//  Copyright © 2018 Tyler hostager. All rights reserved.
//

import UIKit
import AVKit
import WebKit
import AssetsLibrary
import Photos
import MediaPlayer
import UserNotifications
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    @objc var TAG = NSStringFromClass(classForCoder()).components(separatedBy: ".").last! as String
    
    public var managedObjectContext: NSManagedObjectContext!
    public var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.managedObjectContext = SFSharedData.instance.persistentContainer.viewContext
        
        let usrData = NSEntityDescription.entity(
            forEntityName: "SFUser",
            in: self.managedObjectContext
        )
        
        
        #if DEBUG
        print("Application launched")
        #endif
        
        #if DEBUG
        print("Requesting access to \"AVCaptureDevice\"...")
        #endif
        
        // request camera and photos permissions
        self.requestVideosAuthStatus()
        self.requestPhotosAuthStatus()
        
        self.initDefaults(application)
        
        // create shared user object
        SFSharedData.user = NSManagedObject(entity: usrData!, insertInto: ManagedObjectContext.current) as! SFUser
        
        
        
        //print("Initializing test user: \(user.debugDescription)");
        
        
        return true
    }
    
    private func initDefaults(_ application: UIApplication) -> Void {
        application.applicationSupportsShakeToEdit = true
        
        setupNotifications()
    }
    
    private func setupNotifications() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterFullScreen), name: NSNotification.Name(rawValue: "ShouldEnterFullScreen"), object: nil)
    }
    
    @discardableResult
    func requestVideosAuthStatus() -> Bool {
        let avCaptureAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if avCaptureAuthStatus == .notDetermined {
            AVCaptureDevice.requestAccess(
                for: .video,
                completionHandler: { response in
                    if response {
                        #if DEBUG
                        print("\"AVCaptureDevice\" access granted")
                        #endif
                    } else {
                        #if DEBUG
                        print("\"AVCaptureDevice\" access denied")
                        #endif
                    }
            })
        }
        
        return avCaptureAuthStatus == .authorized
    }
    
    @discardableResult
    func requestPhotosAuthStatus() -> Bool {
        let photosAuthStatus = PHPhotoLibrary.authorizationStatus()
        if photosAuthStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization({photosAuthStatus in
                if photosAuthStatus == .authorized {
                    #if DEBUG
                    print("User authorized camera roll access")
                    #endif
                } else {
                    #if DEBUG
                    print("User denied camera roll access")
                    #endif
                }
            })
        }
        
        return photosAuthStatus == .authorized
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    @objc func willEnterFullScreen(_ notification: Notification) -> Void {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SmileFiles")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                //fatalError("Unresolved error \(error), \(error.userInfo)")
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                //fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                print("\n\nERROR: \(nserror) - \(nserror.userInfo)")
            }
        }
    }

    @discardableResult
    public func preloadData() -> Bool {
        let sqlitePath = Bundle.main.path(forResource: "MyDB", ofType: "sqlite")
        let sqlitePath_shm = Bundle.main.path(forResource: "MyDB", ofType: "sqlite-shm")
        let sqlitePath_wal = Bundle.main.path(forResource: "MyDB", ofType: "sqlite-wal")
        
        let URL1 = URL(fileURLWithPath: sqlitePath!)
        let URL2 = URL(fileURLWithPath: sqlitePath_shm!)
        let URL3 = URL(fileURLWithPath: sqlitePath_wal!)
        let URL4 = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/MyDB.sqlite")
        let URL5 = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/MyDB.sqlite-shm")
        let URL6 = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/MyDB.sqlite-wal")
        
        if !FileManager.default.fileExists(atPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/MyDB.sqlite") {
            // Copy 3 files
            do {
                try FileManager.default.copyItem(at: URL1, to: URL4)
                try FileManager.default.copyItem(at: URL2, to: URL5)
                try FileManager.default.copyItem(at: URL3, to: URL6)
                
                print("=======================")
                print("FILES COPIED")
                print("=======================")
                return true
                
            } catch {
                print("=======================")
                print("ERROR IN COPY OPERATION")
                print("=======================")
                return false
            }
        } else {
            print("=======================")
            print("FILES EXIST")
            print("=======================")
            return true
        }
    }
}

