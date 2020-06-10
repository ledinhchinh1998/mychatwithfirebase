//
//  CreateNewFeedViewController.swift
//  MyChat
//
//  Created by Chinh on 6/10/20.
//  Copyright © 2020 Chinh le. All rights reserved.
//

import UIKit

class CreateNewFeedViewController: UIViewController {
    
    @IBOutlet weak var avtImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var inputStatusTextView: UITextView!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var photoLibrary: UIImageView!
    //MARK: Recycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigation()
        configTextView()
    }
    
    //MARK: Config
    private func configNavigation() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Create newfeed"
    }
    
    private func configTextView() {
        inputStatusTextView.delegate = self
        inputStatusTextView.text = "What are you thinking ?"
        inputStatusTextView.textColor = UIColor.lightGray
    }
}

//MARK: UITextViewDelegate
extension CreateNewFeedViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
}
