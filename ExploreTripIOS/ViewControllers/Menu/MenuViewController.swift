//
//  MenuViewController.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/25/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import UIKit
enum LeftMenu: Int {
    case HOME = 0
    case SIGNIN
    case CREATE_ACCOUNT
    case MY_BOOKINGS
}
protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}
class MenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let arrayObjects = ["HOME","SIGN IN","CREATE ACCOUNT","MY BOOKINGS"]
    var mainViewController: UIViewController!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MenuViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayObjects.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.arrayObjects[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu: menu)
        }
    }

}
extension MenuViewController:LeftMenuProtocol{
    func changeViewController(menu: LeftMenu) {
        switch menu {
        case .HOME:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
            break
        case .SIGNIN:
            let loginViewController =  UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            loginViewController.leftMenuDelegate = self
            let navigationController = UINavigationController(rootViewController: loginViewController)
            
            self.slideMenuController()?.changeMainViewController(navigationController, close: true)
            break
        case .CREATE_ACCOUNT:
            let viewController =  UIStoryboard(name: "Registration", bundle: nil).instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
            viewController.leftMenuDelegate = self
            let navigationController = UINavigationController(rootViewController: viewController)
            
            self.slideMenuController()?.changeMainViewController(navigationController, close: true)

            break
        default:
            break
        }
    }
}
