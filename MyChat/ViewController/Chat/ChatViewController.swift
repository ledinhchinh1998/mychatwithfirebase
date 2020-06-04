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

class ChatViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        checkRefExist()
//        IQKeyboardManager.shared.enable = false
        configNavigation()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Config navigationController
    private func configNavigation() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: Config
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MessageTableViewCell.className, bundle: nil), forCellReuseIdentifier: MessageTableViewCell.className)
        tableView.separatorStyle = .none
    }
    
    //MARK: Function
    private func fetchMessages(childRef: String) {
        Contains.message.child(childRef).observe(.value) { [unowned self] (snapchat) in
            var listMessage = [MessageModel]()
            for child in snapchat.children {
                if let child = child as? DataSnapshot {
                    if let message = MessageModel(snapshot: child) {
                        listMessage.append(message)
                    }
                }
            }
            
            self.listMessage.removeAll()
            self.listMessage.append(contentsOf: listMessage)
            self.tableView.reloadData()
        }
    }
    
    private func checkRefExist() {
        var childRef = fromId + "-" + toId
        Contains.message.child(childRef).observeSingleEvent(of: .value) { [unowned self] (snapshot) in
            if snapshot.exists() {
                self.fetchMessages(childRef: childRef)
            } else {
                childRef = self.toId + "-" + self.fromId
                self.fetchMessages(childRef: childRef)
            }
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
    
    //MARK: Action
    @IBAction func handleSendMessage(_ sender: Any) {
        let childRef = Contains.message.child(fromId + "-" + toId)
        let timeStamp = String(Date().timeIntervalSince1970)
        if let text = inputTextField.text {
            let values = [
                "text": text,
                "toID": toId,
                "fromID": fromId,
                "timeStamp": timeStamp
            ]
            
            childRef.childByAutoId().updateChildValues(values as [AnyHashable : Any])
        }
        
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cell: MessageTableViewCell.self, for: indexPath) { (tableViewCell) in
            tableViewCell.messageLbl.text = listMessage[indexPath.row].text
        }
        
        return cell
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
