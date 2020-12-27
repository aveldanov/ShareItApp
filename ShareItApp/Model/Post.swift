//
//  Post.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 12/24/20.
//

import Foundation
import Firebase


class Post {
    private(set) var userName: String!
    private(set) var timeStamp: Date!
    private(set) var postText: String!
    private(set) var numberOfLikes: Int!
    private(set) var numberOfComments: Int!
    private(set) var documentID: String!

    init(userName: String, timeStamp: Date, postText: String, numberOfLikes: Int, numberOfComments: Int, documentID: String) {
        
        self.userName = userName
        self.timeStamp = timeStamp
        self.postText = postText
        self.numberOfLikes = numberOfLikes
        self.numberOfComments = numberOfComments
        self.documentID = documentID
        
    }
    
}
