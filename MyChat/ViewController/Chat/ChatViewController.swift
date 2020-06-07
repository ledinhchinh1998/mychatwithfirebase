//
//  ChatViewController.swift
//  MyChat
//
//  Created by Chinh on 5/30/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import Foundation
import SVProgressHUD

class ChatViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackView: UIStackView!
    
    //MARK: Property
    var listMessage = [MessageModel]()
    var user: UserModel?
    lazy var currentUser: User? = {
        return Auth.auth().currentUser
    }()
    
    var toId: String {
        if let id = user?.id {
            return id
        } else {
            return ""
        }
    }
    
    var fromId: String {
        if let id = currentUser?.uid {
            return id
        } else {
            return ""
        }
    }
    
    var receiver: UserModel?
    var childRefMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configNavigation()
        configTextView()
        fetchUser()
        checkRefExist()
    }
    
    //MARK: Config navigationController
    private func configNavigation() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: Config
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MessageByOtherTableViewCell.className, bundle: nil), forCellReuseIdentifier: MessageByOtherTableViewCell.className)
        tableView.register(UINib(nibName: MessageByCurrentUserTableViewCell.className, bundle: nil), forCellReuseIdentifier: MessageByCurrentUserTableViewCell.className)
        tableView.register(UINib(nibName: MsgImgByOtherTableViewCell.className, bundle: nil), forCellReuseIdentifier: MsgImgByOtherTableViewCell.className)
        tableView.register(UINib(nibName: MsgImgByCurrentUserTableViewCell.className, bundle: nil), forCellReuseIdentifier: MsgImgByCurrentUserTableViewCell.className)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func configTextView() {
        inputTextView.delegate = self
    }
    
    //MARK: Function
    private func fetchUser() {
        SVProgressHUD.show()
        Contains.users.child(toId).observeSingleEvent(of: .value) { [unowned self] (snapshot) in
            self.receiver = UserModel(snapshot: snapshot)
            SVProgressHUD.dismiss()
        }
    }
    
    private func fetchMessages(childRef: String) {
        Contains.message.child(childRef).observe(.value) { [weak self] (snapchat) in
            var listMessage = [MessageModel]()
            for child in snapchat.children {
                if let child = child as? DataSnapshot {
                    if let message = MessageModel(snapshot: child) {
                        listMessage.append(message)
                    }
                }
            }
            
            self?.listMessage.removeAll()
            self?.listMessage.append(contentsOf: listMessage)
            self?.tableView.reloadData()
            self?.tableView.scrollToBottom(animated: false)
        }
    }
    
    private func checkRefExist() {
        SVProgressHUD.show()
        var childRef = fromId + "-" + toId
        Contains.message.child(childRef).observeSingleEvent(of: .value) { [unowned self] (snapshot) in
            if snapshot.exists() {
                self.fetchMessages(childRef: childRef)
                self.childRefMessage = childRef
            } else {
                childRef = self.toId + "-" + self.fromId
                self.fetchMessages(childRef: childRef)
                self.childRefMessage = childRef
            }
            
            SVProgressHUD.dismiss()
        }
    }
    
    @objc func keyboardWasShown(_ notification : Notification) {
        let info = (notification as NSNotification).userInfo
        let value = info?[UIResponder.keyboardFrameEndUserInfoKey]
        if let rawFrame = (value as AnyObject).cgRectValue {
            let keyboardFrame = self.tableView.convert(rawFrame, from: nil)
            let keyboardHeight = keyboardFrame.height
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyboardHeight, right: 0.0)
            self.tableView.contentInset = contentInsets
            self.tableView.scrollIndicatorInsets = contentInsets
        }
    }

    @objc func keyboardWillHide(_ notification : Notification) {
        let contentInsets = UIEdgeInsets.zero
        self.tableView.contentInset = contentInsets
        self.tableView.scrollIndicatorInsets = contentInsets
    }
    
    private func accessPhotoLibrary() {
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
    
    //MARK: Action
    @IBAction func handleSendMessage(_ sender: Any) {
        let timeStamp = String(Date().timeIntervalSince1970)
        if let text = inputTextView.text {
            let values = [
                "text": text,
                "toID": toId,
                "fromID": fromId,
                "timeStamp": timeStamp,
                "sender": fromId
            ]
            
            if let childRefMessage = childRefMessage, inputTextView.text != "" {
                Contains.message.child(childRefMessage).childByAutoId().updateChildValues(values as [AnyHashable: Any])
            }
        }
        
        inputTextView.text = ""
    }
    
    @IBAction func onclickAccessPhotoLibrary(_ sender: Any) {
        accessPhotoLibrary()
    }
}

//MARK: TableView Delegate & Datasource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = listMessage[indexPath.row]
        let avtOfReceive = receiver?.avatarImgUrl ?? ""
        /** Based on data hold on firebase to display cell messages of senders and receivers **/
        if message.sender == fromId {
            /** Based on data hold on firebase, if image != nil, that is, the user is sending an image, thus loading the xid file MsgImgByCurrentUserTableViewCell **/
            if message.image == nil {
                let cell = tableView.dequeueReusableCell(cell: MessageByCurrentUserTableViewCell.self, for: indexPath) { (tableViewCell) in
                    tableViewCell.messageLbl.text = message.text
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(cell: MsgImgByCurrentUserTableViewCell.self, for: indexPath) { (tableViewCell) in
                    if let url = URL(string: message.image ?? "") {
                        tableViewCell.msgImg.sd_setImage(with: url, completed: nil)
                    }
                }
                
                return cell
            }
        } else {
            /** Based on data hold on firebase, if image != nil, that is, the user is sending an image, thus loading the xid file MsgImgByOtherTableViewCell **/
            if message.image == nil {
                let cell = tableView.dequeueReusableCell(cell: MessageByOtherTableViewCell.self, for: indexPath) { (tableViewCell) in
                    tableViewCell.messageLbl.text = message.text
                    if let timeStamp = message.timeStamp {
                        let timeinterval: TimeInterval = (timeStamp as NSString).doubleValue
                        let dateFromServer = NSDate(timeIntervalSince1970:timeinterval)
                        let dateFormater: DateFormatter = DateFormatter()
                        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        tableViewCell.timeStampLbl.text = String(dateFormater.string(from: dateFromServer as Date))
                        if let url = URL(string: avtOfReceive) {
                            tableViewCell.avatarImg?.sd_setImage(with: url, placeholderImage: UIImage(named: "ic-profile"), options: [], context: nil)
                        }
                    }
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(cell: MsgImgByOtherTableViewCell.self, for: indexPath) { (tableViewCell) in
                    if let url = URL(string: message.image ?? "") {
                        tableViewCell.msgImg.sd_setImage(with: url, completed: nil)
                    }
                    
                    if let url = URL(string: avtOfReceive) {
                        tableViewCell.avtImg.sd_setImage(with: url, completed: nil)
                    }
                }
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: UITextFieldDelegate
extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: UITextViewDelegate
extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let height = inputTextView.frame.size.height
        if height > 33 {
            stackView.alignment = .bottom
        } else {
            stackView.alignment = .center
        }
    }
}

//MARK: UIImageController picker
extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let imageName = NSUUID().uuidString
                let storageRef = Storage.storage().reference().child("message-image").child("\(imageName)")
                guard let uploadData = image.jpegData(compressionQuality: 0.2) else {
                    return
                }
                
                SVProgressHUD.show()
                storageRef.putData(uploadData, metadata: nil) { [weak self] (metaData, err) in
                    if err == nil {
                        storageRef.downloadURL(completion: { (url, err) in
                            if let url = url,
                                let child = self?.childRefMessage {
                                let messageRef = Contains.message.child(child).childByAutoId()
                                let childUpdate = ["image": url.absoluteString]
                                messageRef.updateChildValues(childUpdate) { (err, ref) in
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

