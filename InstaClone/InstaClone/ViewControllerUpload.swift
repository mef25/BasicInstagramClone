//
//  ViewControllerUpload.swift
//  InstaClone
//
//  Created by Mehmet Emin Fırıncı on 25.01.2024.
//

import UIKit
import Firebase
import FirebaseStorage
class ViewControllerUpload: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var resim: UIImageView!
    @IBOutlet weak var yazi: UITextField!
    @IBOutlet weak var buton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buton.isEnabled=false
        resim.isUserInteractionEnabled=true
        let tiklama = UITapGestureRecognizer(target: self, action: #selector(openGallery))
        resim.addGestureRecognizer(tiklama)
        
    }
    @objc func openGallery(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing=true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        resim.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil) // işlemi bitiriyor
        buton.isEnabled=true
    }
    func alert(mesaj:String){
        let alarm = UIAlertController(title: "ERROR", message: mesaj, preferredStyle: .alert)
        let buton = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alarm.addAction(buton)
        self.present(alarm, animated: true, completion: nil)
    }
    @IBAction func upload(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = resim.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { metaData, error in
                if error != nil{
                    self.alert(mesaj: error?.localizedDescription ?? "Error")
                }else{
                    imageReference.downloadURL { url, error in
                        if error == nil{
                            let imageurl = url?.absoluteString
                            
                            //DATABASE
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReferance : DocumentReference? = nil
                            let fireStorePost = ["imageUrl" : imageurl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.yazi.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            firestoreReferance = firestoreDatabase.collection("Posts").addDocument(data: fireStorePost, completion: { error in
                                if error != nil{
                                    self.alert(mesaj: error?.localizedDescription ?? "Error")
                                }else{
                                    self.resim.image = UIImage(named: "6")
                                    self.yazi.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                        }else{
                            self.alert(mesaj: error?.localizedDescription ?? "Erorr")
                        }
                    }
                }
            }
        }
    }
    
}
