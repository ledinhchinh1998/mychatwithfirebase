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
import SDWebImage
import SVProgressHUD

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
    @IBOutlet weak var signOutLbl: UILabel!
    
    //MARK: Property
    lazy var currentUser: User? = {
        return Auth.auth().currentUser
    }()
    
    var user: UserModel?
    var ultities = Ultities.shared
    
    //MARK: Recycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configProfile()
    }
    
    //MARK: Config
    private func configLayout() {
        let tapAvatarGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAvatar))
        avatarImg.addGestureRecognizer(tapAvatarGesture)
        avatarImg.isUserInteractionEnabled = true
        containerStackView.addShadowCustom(CGSize(width: 0.0, height: 6.0), 10, 0.5)
        let tapSignOutGesture = UITapGestureRecognizer(target: self, action: #selector(handleSignOut))
        signOutLbl.addGestureRecognizer(tapSignOutGesture)
    }
    
    private func configProfile() {
        if let uid = currentUser?.uid {
            SVProgressHUD.show()
            Contains.users.child(uid).observe(.value) { [unowned self] (snapshot) in
                self.user = UserModel(snapshot: snapshot)
                guard let userName = self.user?.userName,
                    let _ = self.user?.email else {
                        SVProgressHUD.dismiss()
                        return
                }
                
                if let url = URL(string: self.user?.avatarImgUrl ?? "") {
                    self.avatarImg?.sd_setImage(with: url, completed: nil)
                }
                
                self.nameLbl.text = userName
                SVProgressHUD.dismiss()
            }
        }
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
    
    @objc private func handleSignOut() {
        self.push(storyBoard: "Main", type: LoginViewController.self) { (viewController) in
            if ultities.isKeyPresentInUserDefaults(key: "User") {
                let prefs = UserDefaults.standard
                prefs.removeObject(forKey: "User")
            }
        }
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
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let imageName = NSUUID().uuidString
                let storageRef = Storage.storage().reference().child("profile-image").child("\(imageName)")
                guard let uploadData = image.jpegData(compressionQuality: 0.2) else {
                    return
                }
                SVProgressHUD.show()
                storageRef.putData(uploadData, metadata: nil) { (metaData, err) in
                    if err == nil {
                        storageRef.downloadURL(completion: { (url, err) in
                            if let url = url,
                                let uid = self.currentUser?.uid {
                                let userRef = Contains.users.child(uid)
                                let childUpdate = ["avatarImgUrl": url.absoluteString]
                                userRef.updateChildValues(childUpdate) { (err, ref) in
                                    if err == nil {
                                        
                                    } else {
                                        print("Update child values is failed")
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
