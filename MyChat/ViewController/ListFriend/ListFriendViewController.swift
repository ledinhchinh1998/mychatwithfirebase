//
//  ListFriendViewController.swift
//  MyChat
//
//  Created by Chinh le on 6/10/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ListFriendViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Property
    private var listUser = [UserModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        fetchUser()
        configNavigation()
    }
    
    //MARK: Config
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: FriendTableViewCell.className, bundle: nil), forCellReuseIdentifier: FriendTableViewCell.className)
        tableView.separatorStyle = .none
    }
    
    private func configNavigation() {
        navigationItem.title = "List Friend"
    }
    
    //MARK: Function
    private func fetchUser() {
        SVProgressHUD.show()
        Contains.users.observe(.value) { [unowned self] (snapshot) in
            self.listUser.removeAll()
            for child in snapshot.children {
                if let child = child as? DataSnapshot {
                    if let user = UserModel(snapshot: child) {
                        self.listUser.append(user)
                    }
                }
            }
            
            SVProgressHUD.dismiss()
            self.tableView.reloadData()
        }
    }

}

//MARK: UITableView Datasource & Delegate
extension ListFriendViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUser.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = listUser[indexPath.row]
        let cell = tableView.dequeueReusableCell(cell: FriendTableViewCell.self, for: indexPath) { (tableViewCell) in
            tableViewCell.nameLbl.text = user.userName
            if let url = URL(string: user.avatarImgUrl ?? "") {
                tableViewCell.avtImg.sd_setImage(with: url, completed: nil)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = listUser[indexPath.row]
        self.push(storyBoard: nil, type: ChatViewController.self) { (destinationVC) in
            destinationVC?.user = user
        }
    }
}
