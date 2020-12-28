//
//  CreateUserViewController.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 12/26/20.
//

import UIKit
import FirebaseAuth
import Firebase

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
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let username = usernameTextField.text
              else {
            return
        }
        
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error{
                debugPrint("Error creating user", error.localizedDescription)
            }
            
            let changeRequest = authResult?.user.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error{
                    debugPrint(error.localizedDescription)
                }
            })
            
            
            
            guard let userID = authResult?.user.uid else {
                return
            }
            Firestore.firestore().collection(USERS_COLLECTION_REF).document(userID).setData(
                [USERNAME : username,
                 DATE_CREATED: FieldValue.serverTimestamp()]) { (error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }else{
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }

        
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
