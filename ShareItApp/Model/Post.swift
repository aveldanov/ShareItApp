//
//  Post.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 12/24/20.
//

import Foundation


class Post {
    private(set) var username: String!
    private(set) var timeStamp: Date!
    private(set) var postText: String!
    private(set) var numberOfLikes: Int!
    private(set) var numberOfComments: Int!
    private(set) var documentID: String!

    init(username: String,timeStamp: Date,postText: String,numberOfLikes: Int,numberOfComments: Int,documentID: String) {
        
        self.username = username
        self.timeStamp = timeStamp
        self.postText = postText
        self.numberOfLikes = numberOfLikes
        self.numberOfComments = numberOfComments
        self.documentID = documentID
        
    }
    
}
