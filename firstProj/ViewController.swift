//
//  ViewController.swift
//  firstProj
//
//  Created by Drole on 1/23/21.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var LeftCardView: UIImageView!
    
    
    
    @IBOutlet weak var RightCardView: UIImageView!
    
    
    @IBOutlet weak var PressedCountLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        PressedCountLabel.text = "0"
    }

    var counterNumbers : Int = 0

    @IBAction func DealTapped(_ sender: Any) {
        let leftNumber = Int.random(in: 2...14)
        
        let rightNumber = Int.random(in: 2...14)
                
        LeftCardView.image = UIImage(named: "card\(leftNumber)")
        RightCardView.image = UIImage(named: "card\(rightNumber)")
        self.counterNumbers+=1


                self.PressedCountLabel.text = String(self.counterNumbers)
    }
    
    
}

