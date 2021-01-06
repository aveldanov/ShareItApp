//
//  LoginViewController.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 12/26/20.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createUserButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
        createUserButton.layer.cornerRadius = 10
    }
    

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else{
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error{
                debugPrint("Error signing in", error)
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
