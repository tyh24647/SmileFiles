//
//  ViewController.swift
//  SmileFiles
//
//  Created by Tyler hostager on 3/28/18.
//  Copyright © 2018 Tyler hostager. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let kTag = "[ViewController]"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let model = SFSharedData.model!
        //NSLog("%@ \'model\' object initialized successfully: \"%@\"", self.kTag, model)
        
        let user = SFSharedData.user!
        user.uuid = UIDevice.current.identifierForVendor
        
        NSLog(
            "%@ \'user\' object initialized successfully: \n%@",
            self.kTag,
            SFUser.current //user
        )
        
        user.isVerified = false
        user.nickname = "Tyler"
        user.shouldSendEmail = false
        SFSharedData.user = user
        
        //SFSharedData.instance.saveContext()
        
        NSLog(
            "\n\n%@ \'user\' object initialized successfully: \n%@",
            self.kTag,
            SFSharedData.user //user
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController {
            let cwvc = navVC.topViewController as! SafariViewController
            cwvc.urlString = ApplicationConstants.Defaults.Web.url
        }
    }
}

