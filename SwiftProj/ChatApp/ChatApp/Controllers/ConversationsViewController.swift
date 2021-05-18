//
//  ViewController.swift
//  ChatApp
//
//  Created by Drole on 16/05/21.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !isLoggedIn {
             let vcontroller = LoginViewController()
            let nav = UINavigationController(rootViewController: vcontroller)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }

}

