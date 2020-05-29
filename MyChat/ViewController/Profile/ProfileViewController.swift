//
//  ProfileViewController.swift
//  MyChat
//
//  Created by Chinh le on 5/29/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var followerLbl: UILabel!
    @IBOutlet weak var followingLbl: UILabel!
    @IBOutlet weak var photosLbl: UILabel!
    @IBOutlet weak var likeLbl: UILabel!
    @IBOutlet weak var notificationLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var notificationCmtLbl: UILabel!
    @IBOutlet weak var editLbl: UILabel!
    
    @IBOutlet weak var containerStackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
    }
    
    //MARK: Config
    private func configLayout() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAvatar))
        avatarImg.addGestureRecognizer(tapGesture)
        avatarImg.isUserInteractionEnabled = true
        containerStackView.addShadowCustom(CGSize(width: 0.0, height: 6.0), 10, 0.5)
    }
    
    //MARK: Function
    private func viewAvatar() {
        
    }
    
    private func editAvatar() {
        let alert = UIAlertController(title: "Choose option", message: "", preferredStyle: .alert)
        let fromCameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.getImage(fromSourceType: .camera)
        }
        
        let fromPhotoAlbumAction = UIAlertAction(title: "Photo Album", style: .default) { _ in
            self.getImage(fromSourceType: .photoLibrary)
        }
        
        alert.addAction(fromCameraAction)
        alert.addAction(fromPhotoAlbumAction)
        self.present(alert, animated: true)
    }
    
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Selector
    @objc private func handleTapAvatar() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let viewAvatarAction = UIAlertAction(title: "View avatar", style: .default) { _ in
            self.viewAvatar()
        }
        
        let editAvatarAction = UIAlertAction(title: "Edit avatar", style: .default) { _ in
            self.editAvatar()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(viewAvatarAction)
        alert.addAction(editAvatarAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    //MARK: Action
    @IBAction func onclickPhotos(_ sender: Any) {
        
    }
    
    @IBAction func onclickLike(_ sender: Any) {
        
    }
    
    @IBAction func onclickComment(_ sender: Any) {
        
    }
    
    @IBAction func onclickEdit(_ sender: Any) {
        
    }
}

//MARK: ImagePickerController
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage  {
                let storageRef = Storage.storage().reference().child("tst")
                guard let uploadData = image.pngData() else {
                    return
                }
                
                storageRef.putData(uploadData, metadata: nil) { (metaData, err) in
                    if err == nil {
                        storageRef.downloadURL(completion: { (url, err) in
                            if let url = url,
                                let uid = Auth.auth().currentUser?.uid {
                                let userRef = Contains.users.child(uid)
                                let childUpdate = ["avatarImgUrl": "testttt"]
                                userRef.updateChildValues(childUpdate) { (err, ref) in
                                    if err == nil {
                                        
                                    } else {
                                        
                                    }
                                }
                            }
                        })
                    } else {
                        print("Upload data is failed")
                    }
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
