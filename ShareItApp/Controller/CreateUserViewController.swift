//
//  CreateUserViewController.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 12/26/20.
//

import UIKit

class CreateUserViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createUserButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUserButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10

    }
    
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
    }
    
    

}
