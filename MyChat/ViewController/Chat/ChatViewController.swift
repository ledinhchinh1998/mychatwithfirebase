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

class ChatViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Property
    lazy var currentUser: User? = {
        return Auth.auth().currentUser
    }()
    
    var users = [UserModel]()
    let ref = Database.database().reference(withPath: "app-chat")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configCollectionView()
        fetchUser()
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
    
    private func fetchUser() {
        SVProgressHUD.show()
        ref.child("users").observe(.value, with: { (snapshot) in
            for child in snapshot.children {
                let user = UserModel(snapshot: child as! DataSnapshot)
                if let user = user {
                    self.users.append(user)
                }
            }
            self.collectionView.reloadData()
            SVProgressHUD.dismiss()
        }) { (cancel) in
            SVProgressHUD.dismiss()
        }
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cell: ChatTableViewCell.self, for: indexPath) { (tableViewCell) in
            
        }
        
        return cell
    }

}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
}
