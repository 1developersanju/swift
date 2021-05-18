//
//  ViewController.swift
//  randomPhotos
//
//  Created by Drole on 14/05/21.
//

import UIKit

class ViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Get Random Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let colors: [UIColor] = [
        .systemRed,
        .systemBlue,
        .systemTeal,
        .systemPink,
        .systemOrange,
        .systemPurple,
        .systemIndigo,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
        view.addSubview(button)
        getRandomPhoto()
        button.addTarget(self, action: #selector(TappedButton), for: .touchUpInside)
    }
    
   @objc func TappedButton(){
        getRandomPhoto()
    view.backgroundColor = colors.randomElement()
    }

    override func viewDidLayoutSubviews() {
        button.frame = CGRect(x: 30, y: view.frame.size.height-100-view.safeAreaInsets.bottom, width: view.frame.size.width-50, height: 55)
    }
    
    func getRandomPhoto(){
        let urlString
            = "https://source.unsplash.com/random/600*600"
        
        let url = URL(string: urlString)!
        
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        imageView.image = UIImage(data: data)
    }

}

