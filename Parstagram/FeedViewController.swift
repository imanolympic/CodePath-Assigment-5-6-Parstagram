//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Theron Mansilla on 10/23/20.
//

import UIKit
import Parse

class FeedViewController: UIViewController {
    
    @IBOutlet weak var postsTableView: UITableView!
    
    var posts = [PFObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        postsTableView.separatorColor = .none
        
    
    }
    override func viewDidAppear(_ animated: Bool) {
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.postsTableView.reloadData()
        
            }
        }
    }
}



extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post Cell") as! PostTableViewCell
        
        let post = self.posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        
        cell.captionLabel.text = post["caption"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.postImageView.af_setImage(withURL: url)
        
        return cell
    }
    
    
}
