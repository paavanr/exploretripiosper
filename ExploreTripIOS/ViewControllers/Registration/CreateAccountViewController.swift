//
//  CreateAccountViewController.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/26/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    weak var  leftMenuDelegate:LeftMenuProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.addNavigationView()
        self.setNavigationBarItem()
        
        self.registerButton.layer.cornerRadius = 4
        self.registerButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func forgotPasswordButtonClick(_ sender: Any) {
        
    }
    @IBAction func registerButtonClick(_ sender: Any) {
        
        guard let firstname = self.firstNameTextField.text, !(self.firstNameTextField.text?.isEmpty)! else {
            self.present(message: "Please enter username.")
            return
        }
        guard let lastname = self.lastNameTextField.text, !(self.lastNameTextField.text?.isEmpty)! else {
            self.present(message: "Please enter password.")
            return
        }
        guard let email = self.emailTextField.text, !(self.emailTextField.text?.isEmpty)! else {
            self.present(message: "Please enter username.")
            return
        }
        guard let mobilenumber = self.mobileNumberTextField.text, !(self.mobileNumberTextField.text?.isEmpty)! else {
            self.present(message: "Please enter password.")
            return
        }
        guard let password = self.passwordTextField.text, !(self.passwordTextField.text?.isEmpty)! else {
            self.present(message: "Please enter password.")
            return
        }
        guard let confirmpassword = self.confirmPasswordTextField.text, !(self.passwordTextField.text?.isEmpty)! else {
            self.present(message: "Please enter password.")
            return
        }
        
        guard password == confirmpassword else {
            self.present(message: "Please enter password.")
            return
        }
        
        let params = ["FirstName":firstname, "LastName":lastname, "ApiToken":Constants.apiToken,"Email":email, "MobileNumber":mobilenumber,"Password":password,"PhoneCountryCode":"1"]
        self.processServiceRequest(request: RestAPIRouter.userSignUp(params) )
    }
    func processServiceRequest(request:RestAPIRouter) {
        RestAPIController.startRequest(request:request){ serverResponse in
            //Change rootview
            guard let responseData = serverResponse.json else {
                self.present(message: "Error in request")
                return
            }
            print("-------Signup Response------\n \(responseData)")
            
            let user = User(dictionary: responseData)
            guard user.approved! else {
                self.present(message: (user.status?["ErrorMessage"]  as? String) ?? "n/a")
                return
            }
            self.leftMenuDelegate?.changeViewController(menu: .SIGNIN)
            
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
extension CreateAccountViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
