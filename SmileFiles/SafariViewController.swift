//
//  SafariViewController.swift
//  SmileFiles
//
//  Created by Tyler hostager on 3/29/18.
//  Copyright © 2018 Tyler hostager. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

class SafariViewController: UIViewController, SFSafariViewControllerDelegate, UINavigationBarDelegate, WKNavigationDelegate, UINavigationControllerDelegate {
    //@IBOutlet var webView: WKWebView!
    
    override var navigationItem: UINavigationItem {
        get { return super.navigationItem }
    }
    
    override var navigationController: UINavigationController {
        return super.navigationController!
    }
    
    private static var _instance: SafariViewController!
    public private(set) static var instance: SafariViewController! {
        get { return _instance  }
        set { _instance = newValue ?? _instance ?? SafariViewController() }
    }
    
    var urlString: String! = ApplicationConstants.Defaults.Web.url
    var url: URL!
    var safariVC: SFSafariViewController!
    var isFirstLoad = true
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.safariVC != nil {
            self.safariVC.preferredBarTintColor = .red
            self.safariVC.preferredControlTintColor = .red
        }
        
        self.view.tintColor = .red
        
        if !isFirstLoad {
            //self.perform(#selector(openInSafari))
            openInSafari(sender: self.view)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController.delegate = SafariViewController.instance ?? self
        
        // Do any additional setup after loading the view.
        
        if (self.isFirstLoad) {
            print("Initializing Safari view...")
            
            // do setup before loading the view
            self.registerNotifications()
            self.updateWebView()
            self.configureWebView()
            self.configureInAppSafari()
            
            isFirstLoad = false
        }
        
        self.view.tintColor = .red
        
        
        print("WebView object Initialized successfully")
    }
    
    private func registerNotifications() -> Void {
        let notificationName = Notification.Name("updateWebView")
        NotificationCenter.default.addObserver(self, selector: #selector(updateWebView), name: notificationName, object: nil)
    }
    
    @objc func updateWebView() {
        /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let serverURL = appDelegate.serverURL!
        load_url(server_url: serverURL)
 */
        self.view.layoutSubviews()
    }
    
    private func configureWebView() -> Void {
        print("configuring...")
        
        /*
        if self.webView == nil {
            self.webView = WKWebView(frame: self.view.frame)
        }
        
        self.webView.allowsLinkPreview = true
        self.webView.allowsBackForwardNavigationGestures = true
        self.webView.customUserAgent = "Mozilla"    // TODO maybe change back to mobile safari
        self.webView.navigationDelegate = self
        //reloadInputViews()
 */
        
        
        
    }
    
    private func configureInAppSafari() -> Void {
        //self.safariVC.delegate = self
        //self.safariVC.navigationController!.delegate = self
        //self.safariVC.navigationController!.navigationBar.delegate = self

    }
    
    @IBAction func openInSafari(sender: AnyObject) {
        print(String(format:"[%@] opening url \"%@\" in safari...", sender as! CVarArg, self.urlString))
        let url: URL! = URL(fileURLWithPath: urlString)
        
        if UIApplication.shared.canOpenURL(url) {
            
            /*
             UIApplication.performSelector(
             onMainThread: #selector(openURL(completionHandler)),
             with: nil,
             waitUntilDone: true
             )
             */
            
            /* UIApplication.perform(#selector(openURL(completionHandler)))
             */
            
//
//            let svc = SFSafariViewController(url: URL(string: self.urlString)!)
//            svc.delegate = self
//
//            //svc.navigationController!.delegate = self
//            //self.present(svc, animated: true, completion: nil)
//
//            //svc.modalTransitionStyle = .coverVertical
//            svc.modalPresentationStyle = .formSheet
//            svc.modalTransitionStyle = .crossDissolve
            //svc.modalPresentationCapturesStatusBarAppearance = true
            //svc.isModalInPopover = false
            
            //self.webView.addSubview(svc.view)
            self.safariVC = SFSafariViewController(url: URL(string: self.urlString)!)
            self.safariVC.delegate = self
            
            //self.view.addSubview(self.safariVC.view)
            //self.view.addSubview(svc.view)
            
            //svc.navigationController!.delegate = self
            
            self.present(
                self.safariVC,//svc,
                animated: true,
                completion: {
                    self.view.layoutIfNeeded()
            })
            
            
            
        } else {
            print("[\(sender)] ERROR: Unable to open the specified URL -> \"\(urlString)\"")
        }
        
        print("[\(sender)] Button pressed for action -> \"open in safari\"")
    }
    
    @objc func openURL(_ url: URL, _ options: [String : Any]? = [:], completionHandler: ((Bool) -> Void)? = nil) -> Bool {
        var isFinished = false
        
        if self.safariVC! != nil {
            
            
            //while !self.safariVC!.isBeingPresented {
            
            self.safariVC.navigationController!.setNavigationBarHidden(true, animated: false)
            self.safariVC.navigationController!.setToolbarHidden(false, animated: false)
            //self.safariVC.view.layou = [ .bottomAnchor += self.tabBarController?.tabBar.frame.height ]
            
            self.safariVC.updateViewConstraints()
            self.safariVC.view.frame = CGRect(
                x: 0 + self.tabBarController!.tabBar.frame.height,
                y: 0,
                width: self.view.frame.width,
                height: self.view.frame.height - self.tabBarController!.tabBar.frame.height
            )
            
            self.safariVC.view.setNeedsLayout()
            
            self.present(self.safariVC!, animated: true, completion: {
                self.safariVC.view.layoutIfNeeded()
                self.view.layoutSubviews()
            })
            
            
            //}
        }
        
        /*
         UIApplication.shared.open(url, options: options!, completionHandler: ({ (done: Bool) -> Void in
         
         if !self.safariVC!.isBeingPresented {
         if self.safariVC!.view != nil {
         self.present(self.safariVC!, animated: true, completion: nil)
         return completionHandler(done)
         }
         }
         
         completionHandler!(done)
         }(isFinished)))
         */
        
        return true
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        //controller.dismiss(animated: true, completion: nil)
        
        DispatchQueue.main.async(execute: {
            controller.dismiss(animated: false, completion: {
                print("[%@] Controller \"%@\" -> View controller did finish")
                while controller.isBeingPresented {
                    print("[%@] Dismissing Safari view", controller)
                }
            })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {
        
    }
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        controller.delegate = self
        controller.configuration.barCollapsingEnabled = true
    }
    
    
//    func safariViewController(_ controller: SFSafariViewController, activityItemsFor URL: URL, title: String?) -> [UIActivity] {
//
//    }
    
    func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
        
    }
    
    func navigationBar(_ navigationBar: UINavigationBar, didPush item: UINavigationItem) {
        //navigationBar.items.
        navigationController.navigationBar.addSubview(UISearchBar(frame: self.navigationController.navigationBar.frame))
        
    }
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        return (super.navigationController?.navigationBar.delegate?.navigationBar!(navigationBar, shouldPop: item))!
    }

    func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        return (super.navigationController?.navigationBar.delegate?.navigationBar!(navigationBar, shouldPush: item))!
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        if viewController == self.safariVC as UIViewController {
//            viewController.navigationController?.navigationBar.delegate = self
//
//        }
//

    }
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return .all
    }
    
    func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {
        return .portrait
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return super.navigationController!.delegate!.navigationController!(navigationController, interactionControllerFor: animationController)!
    }
    
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return super.navigationController?.delegate?.navigationController!(
//            navigationController,
//            animationControllerFor: operation,
//            from: fromVC,
//            to:toVC
//        )
//    }
//
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    
        
        webView.navigationDelegate = self
        
        
 
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
         if let navVC = segue.destination as? UINavigationController {
         let cwvc = navVC.topViewController as! SafariViewController
         cwvc.urlString = self.urlString
         }
         */
        
        
        if self.safariVC == nil {
            //self.safariVC = SFSafariViewController(url: NSURL(string: self.urlString)! as URL)
            //self.safariVC = SFSafariViewController(url: URL(string: self.urlString)!)
            self.safariVC.preferredControlTintColor = .red
            self.safariVC.delegate = SafariViewController.instance
        }
        
        self.present(self.safariVC, animated: true, completion: {
            self.view.setNeedsLayout()
            self.view.layoutSubviews()
            self.view.layoutIfNeeded()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SafariViewController.instance = self
        SafariViewController.instance.safariVC = self.safariVC
    }
}
