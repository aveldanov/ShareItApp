//
//  AddPostViewController.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 12/23/20.
//

import UIKit

class AddPostViewController: UIViewController, UITextViewDelegate {
//MARK: - Outlets
    
    
    @IBOutlet weak var categorySegment: UISegmentedControl!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
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
    }
    
    @IBAction func CategoryChanged(_ sender: UISegmentedControl) {
    }
}
