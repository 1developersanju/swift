//
//  ViewController.swift
//  ios_Calculator
//
//  Created by Drole on 12/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOnScreen:Int = 0;
    var previousNumber:Int = 0;
    var performingMath = false;
    var operation = 0;
    var symbol = String("")
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var labelnum: UILabel!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        
        if performingMath == true
        {
            label.text = String(sender.tag-1)
            numberOnScreen = Int(label.text!)!
            performingMath = false;
            
        }
        else
        {
        label.text = label.text! + String(sender.tag-1)
        numberOnScreen = Int(label.text!)!
        }
    }
    
    
    @IBAction func buttons(_ sender: UIButton) {
        if label.text != "" && sender.tag != 11 && sender.tag != 16
        {
            previousNumber = Int(label.text!)!
            if sender.tag == 12 //Divide
            {
                labelText.text = ""
                labelnum.text = "/";

            }
            else if sender.tag == 13 //Multiply
            {
                labelnum.text = "*";

            }
            else if sender.tag == 14 //Subtract
            {
                labelnum.text = "-";

            }
            else if sender.tag == 15 //Add
            {
                labelnum.text = "+";
                label.text = "";

                            }
            operation = sender.tag
            performingMath = true;
        }
         else if sender.tag == 16
         
        {
            labelnum.text = "=";
            labelText.text = "\(previousNumber) \(numberOnScreen)";

            if operation == 12
            {
                label.text = String(previousNumber / numberOnScreen)
            }
            else if operation == 13
            {
                label.text = String(previousNumber * numberOnScreen)
            }
            else if operation == 14
            {
                label.text = String(previousNumber - numberOnScreen)
            }
            else if operation == 15
            {
                label.text = String(previousNumber + numberOnScreen)
            }
        }
         else if sender.tag == 11
         {
            label.text = ""
            previousNumber = 0;
            numberOnScreen = 0;
            labelnum.text = ""
            labelText.text = ""
         }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

