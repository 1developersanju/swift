//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Drole on 16/05/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    
    private let label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.text = "Come In"
        label.textColor = .systemYellow
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private let emailField: UITextField = {
       let emailField = UITextField()
        emailField.placeholder = "Email Adress"
        emailField.autocapitalizationType = .none
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        emailField.autocorrectionType = .no
        emailField.layer.cornerRadius = 12
        emailField.layer.borderWidth = 1
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        return emailField
    }()

    private let passwordField: UITextField = {
       let passwordField = UITextField()
        passwordField.placeholder = "Password..."
        passwordField.isSecureTextEntry = true
        passwordField.returnKeyType = .done
        passwordField.leftViewMode = .always
        passwordField.layer.cornerRadius = 12
        passwordField.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        passwordField.layer.borderWidth = 1

        passwordField.layer.borderColor = UIColor.lightGray.cgColor
        return passwordField
    }()


    private let  button : UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemYellow
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "Log In"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(tappedRegister))
        
        button.addTarget(self,
                         action: #selector(loginButtonTapped),
                         for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(label)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(button)


        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 80, width: scrollView.width, height: 100)
        
        emailField.frame = CGRect(x: 30,
                                  y: label.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom+10,
                                     width: scrollView.width-60,
                                     height: 52)
     
        button.frame = CGRect(x: 25,
                              y: passwordField.bottom+25,
                              width: scrollView.width-50,
                              height: 52)

    }
    
    @objc private func loginButtonTapped(){
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()

        guard let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        // Firebase log In
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {authResult, error in
            guard let result = authResult, error == nil else{
                print("Failed to login user with email: \(email)")
                return
            }
            let user = result.user
            print("logged in : \(user)")
        })
    }
    
    func alertUserLoginError(){
        let alert = UIAlertController(title: "Oops!",
                                      message: "Please enter all the informations. ",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func tappedRegister(){
        let vcontroller = RegisterViewController()
        vcontroller.title = "Create Account"
        navigationController?.pushViewController(vcontroller, animated: true)
    }

}


extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            loginButtonTapped()
        }
        
        return true
    }
}
