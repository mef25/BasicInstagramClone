//
//  TableViewCell.swift
//  InstaClone
//
//  Created by Mehmet Emin Fırıncı on 29.01.2024.
//

import UIKit
import Firebase
class TableViewCell: UITableViewCell {
    @IBOutlet weak var userimage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeButon(_ sender: Any) {
        let fireStoreDB = Firestore.firestore()
        if let likeCount = Int(like.text!){
            let likeStore = ["likes" : likeCount+1] as [String : Any]
            fireStoreDB.collection("Posts").document(label.text!).setData(likeStore, merge: true)
        }
        
    }
    
}
