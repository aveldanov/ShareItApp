//
//  AddPostViewController.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 12/23/20.
//

import UIKit
import Firebase

class AddPostViewController: UIViewController, UITextViewDelegate {
    //MARK: - Outlets
    
    
    @IBOutlet weak var categorySegment: UISegmentedControl!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    
    //MARK: - Variables
    private var selectedCategory = PostCategory.funny.rawValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postButton.layer.cornerRadius = 4
        postTextView.layer.cornerRadius = 4
        postTextView.text = "My post..."
        postTextView.textColor = .lightGray
        postTextView.delegate = self
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        postTextView.text = ""
        postTextView.textColor = .darkGray
        
    }
    
    
    
    
    @IBAction func postButtonClicked(_ sender: UIButton) {
        guard let userName = userNameTextField.text else {
            return
        }
        
        
        Firestore.firestore().collection("posts").addDocument(data: [
            CATEGORY: selectedCategory,
            NUM_LIKES: 0,
            NUM_COMMENTS: 0,
            POST_TEXT: postTextView.text,
            TIME_STAMP: FieldValue.serverTimestamp(),
            USERNAME: userName
        ]) { (error) in
            if let error = error{
                debugPrint("Error adding document:", error)
            }else{
                // go to prev view controller in a stack
                self.navigationController?.popViewController(animated: true)
               
            }
        }
    }
    
    @IBAction func CategoryChanged(_ sender: UISegmentedControl) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = PostCategory.funny.rawValue
        case 1:
            selectedCategory = PostCategory.serious.rawValue
        default:
            selectedCategory = PostCategory.crazy.rawValue
        }
    }
}
