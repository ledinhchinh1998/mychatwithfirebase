//
//  ChatViewController.swift
//  MyChat
//
//  Created by Chinh le on 5/27/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Property
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        configCollectionView()
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
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReuseableCell(cell: UserOnlineCollectionViewCell.self, for: indexPath) { (collectionViewCell) in
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 75)
    }
}
