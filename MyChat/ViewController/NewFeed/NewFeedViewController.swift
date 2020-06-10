//
//  NewFeedViewController.swift
//  MyChat
//
//  Created by Chinh le on 6/10/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase

class NewFeedViewController: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var avtImg: UIImageView!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Property
    private lazy var currentUser: User? = {
        return Auth.auth().currentUser
    }()
    
    private var user: UserModel?
    
    //MARK: Recycle Viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configTableView()
        fetchCurrentUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    //MARK: Config
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 1000
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: NewFeedTableViewCell.className, bundle: nil), forCellReuseIdentifier: NewFeedTableViewCell.className)
    }
    
    private func configView() {
        
    }
    
    //MARK: Function
    private func fetchCurrentUser() {
        if let uid = currentUser?.uid {
            Contains.users.child(uid).observe(.value) { [weak self] (snapshot) in
                self?.user = UserModel(snapshot: snapshot)
                if let url = URL(string: self?.user?.avatarImgUrl ?? "") {
                    self?.avtImg.sd_setImage(with: url, completed: nil)
                }
            }
        }
    }
    
    //MARK: Action
    @IBAction func onclickSearch(_ sender: Any) {
        
    }
    
    @IBAction func onclickMessage(_ sender: Any) {
        tabBarController?.selectedIndex = 1
    }
    
}

//MARK: UItableView Delegate & Datasource
extension NewFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cell: NewFeedTableViewCell.self, for: indexPath) { (tableViewCell) in
            
        }
        
        return cell
    }
}
