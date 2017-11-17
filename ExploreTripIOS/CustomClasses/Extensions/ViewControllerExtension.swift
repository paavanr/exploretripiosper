//
//  ViewControllerExtension.swift
//  truman
//
//  Created by Mashesh Somineni on 10/6/17.
//  Copyright © 2017 Mashesh Somineni. All rights reserved.
//

import UIKit

public extension UIViewController {
    func addNavigationView(){
        let logo = UIImage(named: "etLogo.png")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit // set imageview's content mode
        self.navigationItem.titleView = imageView
    }

    @objc
    public func pushOrPresent(_ viewController:UIViewController, animated:Bool) {
        if let navController = self.navigationController {
            navController.pushViewController(viewController, animated: animated)
        } else {
            self.present(viewController, animated: animated)
        }
    }
    /// Convenience method to present strings as alerts
    ///
    /// Notes:
    ///  - This method may be called on any thread.  It will always dispatch to the main queue.
    ///  - The completion block, if provided, is called after the alert is presented.
    ///
    /// - Returns: Nothing.
    public func present(message: String, animated: Bool=true, completion: @escaping ()->Void = { _ in }, onDismiss: @escaping()->Void = { _ in }) {
        self.present(title: "Error", message: message, animated: animated, completion: completion, onDismiss: onDismiss)
    }
    
    /// Convenience method to show custom title and message in alert view
    ///
    /// Notes:
    ///  - This method may be called on any thread.  It will always dispatch to the main queue.
    ///  - The completion block, if provided, is called after the alert is presented.
    ///
    /// - Returns: Nothing.
    public func present(title:String, message: String, animated: Bool=true, dismiss:String = "Okay" , completion: @escaping ()->Void = { _ in }, onDismiss: @escaping()->Void = { _ in }) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let a = UIAlertAction(title: dismiss, style: .cancel) { _ in
            onDismiss()
        }
        alertController.addAction(a)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: animated, completion: completion)
        }
    }
    
    /// Convenience method to present errors as alerts
    ///
    /// Notes:
    ///  - This method may be called on any thread.  It will always dispatch to the main queue.
    ///  - The completion block, if provided, is called after the alert is presented.
    ///
    /// - Returns: Nothing.
    public func present(error: Error?, animated:Bool=true, completion: @escaping ()->Void = { _ in }) {
        guard let error = error else { return }
        let msg = error.localizedDescription
        
        self.present(message: msg, animated: animated, completion: completion)
    }
    
    /// Convenience method to present errors as alerts
    ///
    /// Notes:
    ///  - This method may be called on any thread.  It will always dispatch to the main queue.
    ///  - The completion block, if provided, is called after the alert is presented.
    ///
    /// - Returns: Nothing.
    @objc public func presentError(_ error: Error?, animated:Bool, completion: @escaping ()->Void = { _ in }) {
        self.present(error: error, animated: animated, completion: completion)
    }
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        //self.addRightBarButtonWithImage(UIImage(named: "menu")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }

}
