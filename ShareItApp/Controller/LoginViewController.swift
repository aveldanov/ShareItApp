//
//  LoginViewController.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 12/26/20.
//

import UIKit

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
    }
    @IBAction func createUserButtonTapped(_ sender: UIButton) {
    }
    
    
}
