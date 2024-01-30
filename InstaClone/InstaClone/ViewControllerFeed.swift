//
//  ViewControllerFeed.swift
//  InstaClone
//
//  Created by Mehmet Emin Fırıncı on 25.01.2024.
//

import UIKit
import Firebase
import Kingfisher
class ViewControllerFeed: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var usernameArray = [String]()
    var commentArray = [String]()
    var imageArray = [String]()
    var likeArray = [Int]()
    var idArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource=self
        tableView.delegate=self
        getDataFromFirestore()
    }
    
    func getDataFromFirestore(){
        let fireStoreDB = Firestore.firestore()
        fireStoreDB.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil{
                print("error")
            }else{
                if snapshot?.isEmpty == false{
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.commentArray.removeAll(keepingCapacity: false)
                    self.usernameArray.removeAll(keepingCapacity: false)
                    self.idArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        let id = document.documentID
                        self.idArray.append(id)
                        
                        if let username = document.get("postedBy") as? String{
                            self.usernameArray.append(username)
                        }
                        if let comment = document.get("postComment") as? String{
                            self.commentArray.append(comment)
                        }
                        if let imageUrl = document.get("imageUrl") as? String{
                            self.imageArray.append(imageUrl)
                        }
                        if let like = document.get("likes") as? Int{
                            self.likeArray.append(like)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.comment.text = commentArray[indexPath.row]
        cell.userName.text = usernameArray[indexPath.row]
        cell.like.text = String(likeArray[indexPath.row])
        cell.userimage.kf.setImage(with: URL(string: self.imageArray[indexPath.row]))
        cell.label.text = idArray[indexPath.row]
        return cell
    }
  
    
}
