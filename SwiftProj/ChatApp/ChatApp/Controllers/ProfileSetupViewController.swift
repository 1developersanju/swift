//
//  ProfileSetupViewController.swift
//  ChatApp
//
//  Created by Drole on 16/05/21.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class ProfileSetupViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let data = ["Move Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self

    }
    


}

extension ProfileSetupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .systemYellow
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alertActionSheet = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .actionSheet)
        alertActionSheet.addAction(UIAlertAction(title: "Log Out",
                                      style: .destructive,
                                      handler: { [weak self] _ in
                                        guard let strongSelf = self else {
                                            return
                                        }
                                        
                                       //Google log out
                                        GIDSignIn.sharedInstance()?.signOut()
                                        do {
                                            try FirebaseAuth.Auth.auth().signOut()
                                            
                                            let vcontroller = LoginViewController()
                                            let nav = UINavigationController(rootViewController: vcontroller)
                                            nav.modalPresentationStyle = .fullScreen
                                            strongSelf.present(nav, animated: true)
                                            
                                            
                                        } catch {
                                            print("Logout Failed")
                                        }
                                        
                                      }))
        alertActionSheet.addAction(UIAlertAction(title: "Cancel",
                                                 style: .cancel,
                                                 handler: nil))
         
        present(alertActionSheet, animated: true)
        
        
    }
}

