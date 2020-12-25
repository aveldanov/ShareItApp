//
//  ViewController.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 12/22/20.
//

import UIKit
import Firebase

enum PostCategory: String {
    case serious = "serious"
    case funny = "funny"
    case crazy = "crazy"
    case popular = "popular"
}

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
//MARK: - Outlets
    
    
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    
    //MARK: - Variables
    
    private var posts = [Post]()
    private var postCollectionRef: CollectionReference! // reference to a database name
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        postCollectionRef = Firestore.firestore().collection(POSTS_COLLECTION_REF)

    }
    override func viewWillAppear(_ animated: Bool) {
        postCollectionRef.getDocuments { [self] (snapshot, error) in
            if let error = error{
               debugPrint("Error fetching posts", error)
            }else{
                guard let snapshot = snapshot else {
                    return
                }
                for document in snapshot.documents{
                    let data = document.data()
                    let userName = data[USERNAME] as? String ?? "Anonymous"
                    let timeStamp = data[TIME_STAMP] as? Date ?? Date()
                    let postText = data[POST_TEXT] as? String ?? ""
                    let numOfLikes = data[NUM_LIKES] as? Int ?? 0
                    let numOfComments = data[NUM_COMMENTS] as? Int ?? 0
                    let documentID = document.documentID
                    
                    let post = Post(userName: userName, timeStamp: timeStamp, postText: postText, numberOfLikes: numOfLikes, numberOfComments: numOfComments, documentID: documentID)
                    
                    self.posts.append(post)
                }
                tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?  PostTableViewCell{
            
            cell.configureCell(post: posts[indexPath.row])
            return cell

        }else{
            return UITableViewCell()
        }
        
        
    }

}

