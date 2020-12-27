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
    
    
    class func parseData(snapshot: QuerySnapshot?)->[Post]{
        var posts = [Post]()
        
        
        guard let snapshot = snapshot else {
            return posts
        }
        for document in snapshot.documents{
            let data = document.data()
            let userName = data[USERNAME] as? String ?? "Anonymous"
            let timeStampFB = data[TIME_STAMP] as? Timestamp ?? Timestamp()
            let timeStamp = timeStampFB.dateValue()
            let postText = data[POST_TEXT] as? String ?? ""
            let numOfLikes = data[NUM_LIKES] as? Int ?? 0
            let numOfComments = data[NUM_COMMENTS] as? Int ?? 0
            let documentID = document.documentID
            
            let post = Post(userName: userName, timeStamp: timeStamp, postText: postText, numberOfLikes: numOfLikes, numberOfComments: numOfComments, documentID: documentID)
            
            posts.append(post)
        }
        
        return posts
    }
    
}
