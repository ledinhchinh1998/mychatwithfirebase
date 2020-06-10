//
//  ChatViewController.swift
//  MyChat
//
//  Created by Chinh le on 5/27/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import SDWebImage
import IQKeyboardManagerSwift

class ListChatViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topAvtImg: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Property
    lazy var currentUser: User? = {
        return Auth.auth().currentUser
    }()
    
    lazy var currentUserUID: String = {
        return (currentUser?.uid ?? "")
    }()
    
    var users = [UserModel]()
    var chatsHistory = [UserModel]()
    var lastMessages = [LastMessageModel]()
    var util = Ultities.shared
        
    //MARK: Recycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configCollectionView()
        fetchMessage()
        fetchUser()
        searchBar.delegate = self
//        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigation()
    }
    
    //MARK: Config
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ChatTableViewCell.className, bundle: nil), forCellReuseIdentifier: ChatTableViewCell.className)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: UserOnlineCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: UserOnlineCollectionViewCell.className)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func configNavigation() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        Contains.users.child(currentUser?.uid ?? "").observeSingleEvent(of: .value) { [unowned self] (snapshot) in
            let currentUser = UserModel(snapshot: snapshot)
            if let url = URL(string: currentUser?.avatarImgUrl ?? "") {
                self.topAvtImg.sd_setImage(with: url, completed: nil)
            }
        }
    }
    
    private func configView() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onclickProfile))
    }
    
    //MARK: Function
    private func fetchUser() {
        SVProgressHUD.show()
        Contains.users.observe(.value, with: { [weak self] (snapshot) in
            var users = [UserModel]()
            self?.users.removeAll()
            for child in snapshot.children {
                if let child = child as? DataSnapshot {
                    if child.key != self?.currentUser?.uid {
                        let user = UserModel(snapshot: child)
                        user?.id = child.key
                        let value = ["id": child.key]
                        Contains.users.child(child.key).updateChildValues(value)
                        if let user = user {
                            users.append(user)
                        }
                    }
                }
            }
            
            
            self?.users.append(contentsOf: users)
            self?.collectionView.reloadData()
            SVProgressHUD.dismiss()
        }) { (cancel) in
            SVProgressHUD.dismiss()
        }
    }
    
    private func fetchMessage() {
        Contains.historyChat.child(currentUserUID).observe(.value) { [weak self] (snapshot) in /** Iterating historyChat **/
            self?.chatsHistory.removeAll()
            self?.lastMessages.removeAll()
            for child in snapshot.children {
                if let child = child as? DataSnapshot {
                    Contains.users.child(child.key).observeSingleEvent(of: .value) { [weak self] (snapshot) in /** Iterating user **/
                        if let user = UserModel(snapshot: snapshot) {
                            user.id = child.key
                            self?.chatsHistory.append(user)
                        }
                        
                        self?.tableView.reloadData()
                    }
                    
                    if let lastMessage = LastMessageModel(snapshot: child) {
                        self?.lastMessages.append(lastMessage)
                    }
                    
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: Selector
    @objc private func onclickProfile() {
        
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ListChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = chatsHistory[indexPath.row]
        let lastMessage = lastMessages[indexPath.row]
        let cell = tableView.dequeueReusableCell(cell: ChatTableViewCell.self, for: indexPath) { (tableViewCell) in
            tableViewCell.nameUserLbl.text = user.userName
            if let url = URL(string: user.avatarImgUrl ?? "") {
                tableViewCell.avtImage.sd_setImage(with: url, completed: nil)
            }
            
            tableViewCell.timeStampLbl.text = util.timeIntervalToDateString(withInterval: lastMessage.timeStamp ?? "")
            tableViewCell.lastMessageLbl.text = lastMessage.lastMessage
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(storyBoard: nil, type: ChatViewController.self) { (destinationVC) in
            destinationVC?.user = self.chatsHistory[indexPath.row]
        }
    }
    
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ListChatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let user = self.users[indexPath.row]
        let cell = collectionView.dequeueReuseableCell(cell: UserOnlineCollectionViewCell.self, for: indexPath) { (collectionViewCell) in
            collectionViewCell.nameLbl.text = user.userName ?? ""
            if let avatarImgUrl = URL(string: user.avatarImgUrl ?? "") {
                collectionViewCell.avatarImg?.sd_setImage(with: avatarImgUrl, placeholderImage: UIImage(named: "ic-people"), options: [], completed: nil)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.push(storyBoard: nil, type: ChatViewController.self) { (destinationVC) in
            destinationVC?.user = self.users[indexPath.row]
            
        }
    }
}

extension ListChatViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
