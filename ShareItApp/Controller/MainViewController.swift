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
    private var postListener: ListenerRegistration!
    private var selectedCategory = PostCategory.funny.rawValue
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        postCollectionRef = Firestore.firestore().collection(POSTS_COLLECTION_REF)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setListener()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        // free up resources
        postListener.remove()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?  PostTableViewCell{
            
            cell.configureCell(post: posts[indexPath.row])
            //            print(posts[indexPath.row].timeStamp)
            
            return cell
            
        }else{
            return UITableViewCell()
        }
        
        
    }
    
    
    
    @IBAction func categoryChangeTapped(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            selectedCategory = PostCategory.funny.rawValue
        case 1:
            selectedCategory = PostCategory.serious.rawValue
        case 2:
            selectedCategory = PostCategory.crazy.rawValue
        default:
            selectedCategory = PostCategory.popular.rawValue
        }
        // remove post listner and add filter listener
        postListener.remove()
        setListener()
        
    }
    
    func setListener(){
        
        if selectedCategory == PostCategory.popular.rawValue{
            postListener = postCollectionRef
                .order(by: NUM_LIKES, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    self.posts.removeAll()
                    if let error = error{
                        debugPrint("Error fetching posts", error)
                    }else{
                        guard let snapshot = snapshot else {
                            return
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
                            
                            self.posts.append(post)
                        }
                        self.tableView.reloadData()
                    }
                }
            
        }else{
            postListener = postCollectionRef
                .whereField(CATEGORY, isEqualTo: selectedCategory)
                .order(by: TIME_STAMP, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    self.posts.removeAll()
                    if let error = error{
                        debugPrint("Error fetching posts", error)
                    }else{
                        guard let snapshot = snapshot else {
                            return
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
                            
                            self.posts.append(post)
                        }
                        self.tableView.reloadData()
                    }
                }
            
            
            
        }
        
        
        
        
        
    }
    
    
}

