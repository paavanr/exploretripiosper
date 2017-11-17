//
//  LoginViewController.swift
//  Exploretrip_task
//
//  Created by Pavan Kumar on 10/24/17.
//  Copyright © 2017 com.mondee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var usernameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    weak var  leftMenuDelegate:LeftMenuProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.addNavigationView()
        self.setNavigationBarItem()

        self.signinButton.layer.cornerRadius = 4
        self.signinButton.clipsToBounds = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signinButtonClick(_ sender: Any) {
        guard let username = self.usernameTextFiled.text, !(self.usernameTextFiled.text?.isEmpty)! else {
            self.present(message: "Please enter username.")
            return
        }
        guard let password = self.passwordTextFiled.text, !(self.passwordTextFiled.text?.isEmpty)! else {
            self.present(message: "Please enter password.")
            return
        }
        
        let params = ["Username":username, "Password":password, "ApiToken":Constants.apiToken]
        self.processServiceRequest(request: RestAPIRouter.userLogin(params) )
        
    }
    func processServiceRequest(request:RestAPIRouter) {
        RestAPIController.startRequest(request:request){ serverResponse in
            //Change rootview
            
            guard let responseData = serverResponse.json else {
                self.present(message: "Error in request")
                return
            }
            print("-------Login Response------\n \(responseData)")

            let user = User(dictionary: responseData)
            guard user.approved! else {
                self.present(message: (user.status?["ErrorMessage"]  as? String) ?? "n/a")
                return
            }
            
            self.leftMenuDelegate?.changeViewController(menu: .HOME)
            
        }
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
extension LoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



