//
//  ViewController.swift
//  ChatApp
//
//  Created by Drole on 16/05/21.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemGray4
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser  == nil {
             let vcontroller = LoginViewController()
            let nav = UINavigationController(rootViewController: vcontroller)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }

}

