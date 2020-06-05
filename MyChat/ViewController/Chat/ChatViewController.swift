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
    
    var childRefMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        checkRefExist()
        configNavigation()
        configTextView()
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
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        self.view.layoutIfNeeded()
    }
    
    private func configTextView() {
        inputTextView.delegate = self
    }
    
    //MARK: Function
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
}

//MARK: TableView Delegate & Datasource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = listMessage[indexPath.row]
        let cell = tableView.dequeueReusableCell(cell: MessageByOtherTableViewCell.self, for: indexPath) { (tableViewCell) in
            if message.sender == fromId {
                
            } else {
                
            }
            tableViewCell.messageLbl.text = message.text
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

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
