//
//  ViewController.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 12/22/20.
//

import UIKit
import Firebase
import FirebaseAuth

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
    private var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        postCollectionRef = Firestore.firestore().collection(POSTS_COLLECTION_REF)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // tracking user state
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            // if not logged in - popup loginVC
            if user == nil{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyboard.instantiateViewController(identifier: "loginVC")
                loginVC.modalPresentationStyle = .currentContext // full screen size
                self.present(loginVC, animated: true, completion: nil)
            }else{
                self.setListener()

            }
        })
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        // free up resources
        if postListener != nil{
            postListener.remove()

        }
    }
    
    
    
    //MARK: - Data Source Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?  PostTableViewCell{
            cell.configureCell(post: posts[indexPath.row])
            // print(posts[indexPath.row].timeStamp)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    

    func setListener(){
        
        if selectedCategory == PostCategory.popular.rawValue{
            postListener = postCollectionRef
                .order(by: NUM_LIKES, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    if let error = error{
                        debugPrint("Error fetching posts", error)
                    }else{
                        self.posts.removeAll()
                        self.posts = Post.parseData(snapshot: snapshot)
                        self.tableView.reloadData()
                    }
                }
        }else{
            postListener = postCollectionRef
                .whereField(CATEGORY, isEqualTo: selectedCategory)
                .order(by: TIME_STAMP, descending: true)
                .addSnapshotListener { (snapshot, error) in
                    if let error = error{
                        debugPrint("Error fetching posts", error)
                    }else{
                        self.posts.removeAll()
                        self.posts = Post.parseData(snapshot: snapshot)
                        self.tableView.reloadData()
                    }
                }
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
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        let fireBaseAuth = Auth.auth()
        
        do{
            try fireBaseAuth.signOut()
        }catch let signOutError as NSError{
            
            debugPrint("Error Signing Out", signOutError)
        }
        
    }
    
    
    
}

