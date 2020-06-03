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

class ListChatViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Property
    lazy var currentUser: User? = {
        return Auth.auth().currentUser
    }()
    
    var users = [UserModel]()
    var chatsHistory = [UserModel]()
    var messages = [MessageModel]()
    let ref = Database.database().reference(withPath: "app-chat")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configCollectionView()
        configNavigation()
        
        fetchUser()
        fetchMessage()
    }
    
    //MARK: Config
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ChatTableViewCell.className, bundle: nil), forCellReuseIdentifier: ChatTableViewCell.className)
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: UserOnlineCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: UserOnlineCollectionViewCell.className)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func configNavigation() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: Function
    private func fetchUser() {
        SVProgressHUD.show()
        ref.child("users").observe(.value, with: { (snapshot) in
            var users = [UserModel]()
            for child in snapshot.children {
                if let child = child as? DataSnapshot {
                    let user = UserModel(snapshot: child)
                    user?.id = child.key
                    if let user = user {
                        users.append(user)
                    }
                }
            }
            
            self.users.removeAll()
            self.users.append(contentsOf: users)
            self.collectionView.reloadData()
            SVProgressHUD.dismiss()
        }) { (cancel) in
            SVProgressHUD.dismiss()
        }
    }
    
    private func fetchMessage() {
        SVProgressHUD.show()
        Contains.message.observe(.value) { (snapshot) in
            self.chatsHistory.removeAll()
            for child in snapshot.children {
                if let child = child as? DataSnapshot {
                    Contains.users.child(child.key).observeSingleEvent(of: .value) { (snapshot) in
                        if let user = UserModel(snapshot: snapshot) {
                            self.chatsHistory.append(user)
                        }
                    }
                }
            }
            
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ListChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatsHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cell: ChatTableViewCell.self, for: indexPath) { (tableViewCell) in
            let chat = chatsHistory[indexPath.row]
            DispatchQueue.main.async {
                if let url = URL(string: chat.avatarImgUrl ?? "") {
                    do {
                        let data = try Data(contentsOf: url)
                        tableViewCell.avtImage.image = UIImage(data: data)
                        tableViewCell.nameUserLbl.text = chat.userName
                        let timeStamp = self.messages[indexPath.row].timeStamp
                        if let double = Double(timeStamp ?? "") {
                            let timeStamp = NSDate(timeIntervalSince1970: double)
                            tableViewCell.timeStampLbl.text = timeStamp.description
                        }
                    } catch {
                        print("init data is failed")
                    }
                }
            }
        
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = chatsHistory[indexPath.row]
        self.push(storyBoard: nil, type: ChatViewController.self) { (destinationVC) in
            
        }
    }
    
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ListChatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReuseableCell(cell: UserOnlineCollectionViewCell.self, for: indexPath) { (collectionViewCell) in
            let user = self.users[indexPath.row]
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
