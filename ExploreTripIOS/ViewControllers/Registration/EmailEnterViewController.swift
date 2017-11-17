//
//  EmailEnterViewController.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 11/15/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import UIKit

class EmailEnterViewController: UIViewController {

    @IBOutlet weak var recoverButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addNavigationView()
        //self.setNavigationBarItem()
        
        self.recoverButton.layer.cornerRadius = 4
        self.recoverButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recoverPasswordButtonClick(_ sender: Any) {
        self.performSegue(withIdentifier: "EmailToResetPasswordSegue", sender: self)
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
