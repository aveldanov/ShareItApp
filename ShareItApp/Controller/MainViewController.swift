//
//  ViewController.swift
//  ShareItApp
//
//  Created by Veldanov, Anton on 12/22/20.
//

import UIKit

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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?  PostTableViewCell{
            
            cell.configureCell(post: posts[indexPath.row])
        }
        
        
        return UITableViewCell()
    }

}

