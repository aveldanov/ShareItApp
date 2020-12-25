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
    }
    
    
    func configureCell(post: Post){
        
        
        
        
        
    }


}
