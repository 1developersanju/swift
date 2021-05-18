//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Drole on 16/05/21.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
         let imageView = UIImageView()
         imageView.image = UIImage(named:"personAdd")
        imageView.tintColor = .green
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.text = "lets join"
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private let firstNameField: UITextField = {
       let emailField = UITextField()
        emailField.placeholder = "First Name"
        emailField.autocapitalizationType = .allCharacters
        emailField.autocorrectionType = .no
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        emailField.layer.cornerRadius = 12
        emailField.layer.borderWidth = 1
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        return emailField
    }()
    private let lastNameField: UITextField = {
       let emailField = UITextField()
        emailField.placeholder = "Last Name"
        emailField.autocapitalizationType = .allCharacters
        emailField.autocorrectionType = .no
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        emailField.layer.cornerRadius = 12
        emailField.layer.borderWidth = 1
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame:  CGRect(x: 0, y: 0, width: 5, height: 0))
        return emailField
    }()
    private let emailField: UITextField = {
        let emailField = UITextField()
         emailField.placeholder = "Email Adress"
         emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
         emailField.layer.borderColor = UIColor.lightGray.cgColor
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


    private let  regButton : UIButton = {
       let regButton = UIButton()
        regButton.backgroundColor = .systemGreen
        regButton.layer.masksToBounds = true
        regButton.layer.cornerRadius = 12
        regButton.layer.borderWidth = 1
        regButton.setTitleColor(.white, for: .normal)
        regButton.setTitle("Register", for: .normal)
        regButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return regButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Come in"
        view.backgroundColor = .white
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
//                                                            style: .done,
//                                                            target: self,
//                                                            action: #selector(tappedRegister))
        
        regButton.addTarget(self,
                         action: #selector(regButtonTapped),
                         for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(label)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(regButton)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true

        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedChangeProfilePic))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(gesture)
    }
    @objc private func tappedChangeProfilePic() {
       presentPhotoActionSheet()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        imageView.layer.cornerRadius = imageView.width/2.0
        
        label.frame = CGRect(x: 30,
                             y: 100,
                             width: imageView.width-30,
                             height: 50)
        
        firstNameField.frame = CGRect(x: 30,
                                  y: label.bottom+10,
                                  width: scrollView.width-60,
                                  height: 50)
        
        lastNameField.frame = CGRect(x: 30,
                                  y: firstNameField.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom+10,
                                  width: scrollView.width-60,
                                  height: 52)
        
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom+10,
                                     width: scrollView.width-60,
                                     height: 52)
     
        regButton.frame = CGRect(x: 25,
                              y: passwordField.bottom+25,
                              width: scrollView.width-50,
                              height: 52)

    }
    
    @objc private func regButtonTapped(){
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()

        
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty,
              !firstName.isEmpty,
              !lastName.isEmpty,
              password.count >= 6 else {
            alertUserLoginError()
            return
        }
        // Firebase log In
        
        DatabaseManager.shared.userEmailExists(with: email, completion: {[weak self]exists in
            guard let  strongSelf = self else{
                return
            }
            guard !exists else{
       // user already exists
                strongSelf.alertUserLoginError(message:"User account for that email already exits")

                return
            }
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {authResult, error in
               
                guard authResult != nil , error == nil else {
                    print("error creating user")
                    return
                }
                DatabaseManager.shared.addUser(with: ChatAppUser(firstName: firstName,
                                                                 lastName: lastName,
                                                                 emailAddress: email))
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)

            })
            
        })
    }
    
    func alertUserLoginError(message: String = "Please enter all the informations to create a new account."){
        let alert = UIAlertController(title: "Oops!",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
//    @objc private func tappedRegister(){
//        let vcontroller = RegisterViewController()
//        vcontroller.title = "Create Account"
//        navigationController?.pushViewController(vcontroller, animated: true)
//    }

}


extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            regButtonTapped()
        }
        
        return true
    }
}


extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select Profile Pic",
                                            preferredStyle: .actionSheet)
        
        
        actionSheet.addAction(UIAlertAction(title: "cancel",
                                            style: .cancel,
                                            handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Choose Photo",
                                            style: .default,
                                            handler: {[weak self] _ in
                                                self?.presentPhotoPicker()
                                            }))
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: {[weak self] _ in
                                                self?.presentCamera()
                                            }))
        present(actionSheet, animated: true)
        
        actionSheet.addAction(UIAlertAction(title: "Remove Photo",
                                            style: .default,
                                            handler: {[weak self] _ in
                                                self?.removePhoto()
                                            }))
    }
    
    func presentCamera() {
         let vcontroller = UIImagePickerController()
        vcontroller.sourceType = .camera
        vcontroller.delegate = self
        vcontroller.allowsEditing = true
        present(vcontroller, animated: true)
    }

    func removePhoto() {
        imageView.image = UIImage(named:"personAdd")
    }
    
    func presentPhotoPicker() {
        let vcontroller = UIImagePickerController()
        vcontroller.sourceType = .photoLibrary
       vcontroller.delegate = self
       vcontroller.allowsEditing = true
       present(vcontroller, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)

        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage  else {
            return
        }
        
        self.imageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
