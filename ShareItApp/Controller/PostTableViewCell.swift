//
//  PostTableViewCell.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 12/24/20.
//

import UIKit

class PostTableViewCell: UITableViewCell {
//MARK: - Outlets
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    @IBOutlet weak var likesNumberLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UIGestureRecognizer(target: self, action: #selector(likeTapped))
    }
    
    func likeTapped(){
        
        
    }
    
    
    func configureCell(post: Post){
        userNameLabel.text = post.userName
//        timeStampLabel.text = String(post.timeStamp)
        postTextLabel.text = post.postText
        likesNumberLabel.text = String(post.numberOfLikes)
        
//        print("TIMESTAMP",post.timeStamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, hh:mm"
        let timeStamp = formatter.string(from: post.timeStamp)
        timeStampLabel.text = timeStamp
    }


}
