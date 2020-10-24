//
//  LogInViewController.swift
//  Parstagram
//
//  Created by Theron Mansilla on 10/23/20.
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginToFeed", sender: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let user = PFUser()
        user.username = usernameTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginToFeed", sender: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}


extension LogInViewController {
    
}
