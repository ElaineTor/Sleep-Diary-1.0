//
//  ViewController.swift
//  Sleep Diary 1.0
//
//  Created by VIS Swimming on 25/5/18.
//  Copyright © 2018 TOR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var enterEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
        self.enterName.delegate = self
        self.enterEmail.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enterEmail.resignFirstResponder()
        enterName.resignFirstResponder()
        return (true)
    }

    @IBOutlet weak var LoginButton: UIButton!
    @IBAction func beginDiaryButtonPressed(_ sender: UIButton) {
        if enterName.text! == "" && enterEmail.text == "" {
            
            UIView.animate(withDuration: 0.2, animations: {
                
                let rightTransform  = CGAffineTransform(translationX: 20, y: 0)
                self.enterEmail.transform = rightTransform
                self.enterName.transform = rightTransform
                
            }) { (_) in
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.enterEmail.transform = CGAffineTransform.identity
                    self.enterName.transform = CGAffineTransform.identity
                })
            }
            
        } else {
            
            performSegue(withIdentifier: "enterSegue", sender: nil)
        }
    }
}


