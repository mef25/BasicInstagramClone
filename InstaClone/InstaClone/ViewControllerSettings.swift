//
//  ViewControllerSettings.swift
//  InstaClone
//
//  Created by Mehmet Emin Fırıncı on 25.01.2024.
//

import UIKit
import Firebase
class ViewControllerSettings: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func logoutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "anaekran", sender: nil)
        }catch{
            print("error")
        }
    }
}
