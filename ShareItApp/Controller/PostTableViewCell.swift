//
//  PostTableViewCell.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 12/24/20.
//

import UIKit
import Firebase

class PostTableViewCell: UITableViewCell {
    //MARK: - Outlets
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var likesNumberLabel: UILabel!
    @IBOutlet weak var commentsNumberLabel: UILabel!
    
    
    
    //MARK: - Variables
    private var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likesImage.addGestureRecognizer(tap)
        likesImage.isUserInteractionEnabled = true
    }
    
    @objc func likeTapped(){
        
        // two methods to update likes
//        Method #1
//        Firestore.firestore()
//            .collection(POSTS_COLLECTION_REF)
//            .document(post.documentID)
//            .setData([NUM_LIKES: post.numberOfLikes+1], merge: true) //merge to make sure data is not overriden
        
        // Method #2
        Firestore.firestore().document("posts/\(post.documentID!)")
            .updateData([NUM_LIKES: post.numberOfLikes+1])
        
    }
    
    
    func configureCell(post: Post){
        self.post = post
        
        userNameLabel.text = post.userName
        //        timeStampLabel.text = String(post.timeStamp)
        postTextLabel.text = post.postText
        likesNumberLabel.text = String(post.numberOfLikes)
        commentsNumberLabel.text = String(post.numberOfComments)
        
        
        
        //        print("TIMESTAMP",post.timeStamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timeStamp = formatter.string(from: post.timeStamp)
        timeStampLabel.text = timeStamp
    }
    
    
}
