//
//  LoginViewController.swift
//  WordBook
//
//  Created by Weiran Xiong on 4/29/16.
//  Copyright © 2016 Weiran Xiong. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet var usernameLabel: UITextField!
    @IBOutlet var passwordLabel: UITextField!
    
    
    // MARK: IBActions
    
    @IBAction func login(sender: AnyObject) {
        let username = usernameLabel?.text ?? ""
        let password = passwordLabel?.text ?? ""
        
        let user = User(inputUsername: username, inputPassword: password)
        if let authUser = user.userLogin() {
            print(authUser.username)
        }

    }
    @IBAction func forgetPassword(sender: AnyObject) {
    }
    
    

    
}
