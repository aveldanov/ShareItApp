//
//  CommentTableViewCell.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 1/5/21.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
//MARK: - Outlets
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



}
