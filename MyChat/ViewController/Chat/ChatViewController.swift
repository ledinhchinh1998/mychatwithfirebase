//
//  ChatViewController.swift
//  MyChat
//
//  Created by Chinh on 5/30/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        fetchMessages()
        configNavigation()
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
    }
    
    //MARK: Function
    private func fetchMessages() {
        Contains.message.child(user?.id ?? "").observe(.value) { (snapchat) in
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
    
    //MARK: Action
    @IBAction func handleSendMessage(_ sender: Any) {
        let childRef = Contains.message.child(user?.id ?? "")
        let toId = user?.id
        let fromId = currentUser?.uid
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
