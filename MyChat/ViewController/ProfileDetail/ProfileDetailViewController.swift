//
//  ProfileDetailViewController.swift
//  MyChat
//
//  Created by Chinh le on 6/9/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

enum TableViewCellType: Int, CaseIterable {
    case FIRSTNAME = 0, LASTNAME, SEX, BIRTHDAY, EMAIL, PHONENUMBER, BIO, CHANGEPASSWORD
    
    var user: UserModel? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.fetchCurrentUser()
        return appDelegate.currentUser ?? nil
    }
        
    func setText() -> (String, String) {
        switch self {
        case .FIRSTNAME:
            return ("Firstname", user?.firstName ?? "")
        case .LASTNAME:
            return ("Lastname", user?.lastName ?? "")
        case .SEX:
            return ("Sex", user?.sex ?? "")
        case .BIRTHDAY:
            return ("Birthday", user?.birthDay ?? "")
        case .EMAIL:
            return ("Email", user?.email ?? "")
        case .PHONENUMBER:
            return ("Phone number", user?.phoneNumber ?? "")
        case .BIO:
            return ("bio", user?.bio ?? "")
        case .CHANGEPASSWORD:
            return ("Change password", "")
        }
    }
}

class ProfileDetailViewController: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var avatarImg: UIImageView!
    
    //MARK: Property
    private var datePicker: UIDatePicker?
    
    //MARK: Recycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableVIew()
        configView()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigation()
    }
    
    //MARK: Config
    private func configTableVIew() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ProfileDetailTableViewCell.className, bundle: nil), forCellReuseIdentifier: ProfileDetailTableViewCell.className)
        tableView.separatorStyle = .none
    }
    
    private func configView() {
        if let url = URL(string: appDelegate.currentUser?.avatarImgUrl ?? "") {
            bannerImg.sd_setImage(with: url, completed: nil)
            avatarImg.sd_setImage(with: url, completed: nil)
        }
        
        bannerImg.layer.opacity = 0.8
    }
    
    private func configNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.title = appDelegate.currentUser?.userName
        let rightBarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(addTapped))
        rightBarButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = rightBarButton

    }
    
    //MARK: Function
    
    
    //MARK: Selector
    @objc private func addTapped() {
        
    }
    
    private func showDatePicker(indexPath: IndexPath) {
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(myDatePicker)
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            print("Selected Date: \(myDatePicker.date)")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

}

//MARK: UITableView Delegate & Datasource
extension ProfileDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = TableViewCellType(rawValue: indexPath.row)
        let cell = tableView.dequeueReusableCell(cell: ProfileDetailTableViewCell.self, for: indexPath) { (tableViewCell) in
            switch type {
            case .FIRSTNAME:
                let tuple = type?.setText()
                tableViewCell.leftLabel.text = tuple?.0
                tableViewCell.rightLabel.text = tuple?.1
            case .LASTNAME:
                let tuple = type?.setText()
                tableViewCell.leftLabel.text = tuple?.0
                tableViewCell.rightLabel.text = tuple?.1
            case .SEX:
                let tuple = type?.setText()
                tableViewCell.leftLabel.text = tuple?.0
                tableViewCell.rightLabel.text = tuple?.1
            case .BIRTHDAY:
                let tuple = type?.setText()
                tableViewCell.leftLabel.text = tuple?.0
                tableViewCell.rightLabel.text = tuple?.1
            case .EMAIL:
                let tuple = type?.setText()
                tableViewCell.leftLabel.text = tuple?.0
                tableViewCell.rightLabel.text = tuple?.1
            case .PHONENUMBER:
                let tuple = type?.setText()
                tableViewCell.leftLabel.text = tuple?.0
                tableViewCell.rightLabel.text = tuple?.1
            case .BIO:
                let tuple = type?.setText()
                tableViewCell.leftLabel.text = tuple?.0
                tableViewCell.rightLabel.text = tuple?.1
            case .CHANGEPASSWORD:
                let tuple = type?.setText()
                tableViewCell.leftLabel.text = tuple?.0
                tableViewCell.rightLabel.text = tuple?.1
            default:
                break
            }
        }
        
        return cell
    }
    
    
}
