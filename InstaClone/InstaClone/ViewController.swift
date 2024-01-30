//
//  ViewController.swift
//  InstaClone
//
//  Created by Mehmet Emin Fırıncı on 25.01.2024.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // SceneDelegate sayfasında kod var
    }
    
    

    @IBAction func signInButton(_ sender: Any) {
        if mailText.text != "" && passwordText.text != ""{
            Auth.auth().signIn(withEmail: mailText.text!, password: passwordText.text!) { cevap, error in
                if error != nil{
                    self.alert(mesaj: error?.localizedDescription ?? "ERROR")
                }else{
                    self.performSegue(withIdentifier: "pencere2", sender: nil)
                }
            }
        }else{
            alert(mesaj: "Username/Password is wrong")
        }
    }
    
    
    
    @IBAction func signUpButton(_ sender: Any) {
        if mailText.text != "" && passwordText.text != ""{
            Auth.auth().createUser(withEmail: mailText.text!, password: passwordText.text!) { cevap, error in
                if error != nil{
                    self.alert(mesaj: error?.localizedDescription ?? "ERROR")
                }else{
                    self.performSegue(withIdentifier: "pencere2", sender: nil)
                }
            }
        }else{
           alert(mesaj: "Username/Password is wrong")
        }
        
    }
    
    
    
    
    func alert(mesaj:String){
        let alarm = UIAlertController(title: "ERROR!", message: mesaj, preferredStyle: .alert)
        let buton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alarm.addAction(buton)
        self.present(alarm, animated: true, completion: nil)
    }
    
    
    
    
}

