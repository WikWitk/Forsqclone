//
//  ViewController.swift
//  ForsqClone
//
//  Created by Wiktor Witkowski on 08/01/2024.
//

import UIKit
import Parse 

class ViewController: UIViewController {

    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var usrTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // key-value pairing
        
//        let parseObject = PFObject(className: "Cars")
//        parseObject["name"] = "Ferrari"
//        parseObject["HP"] = 600
//        parseObject.saveInBackground { (success, error) in
//            if error != nil {
//                print(error?.localizedDescription)
//            }else {
//                print ("uploaded")
//            }
//        }
        
//        let query = PFQuery(className: "Cars")
////       sortowanie query.whereKey(<#T##key: String##String#>, equalTo: <#T##Any#>)
//        query.findObjectsInBackground { (objects, error) in
//            if error != nil {
//                print(error?.localizedDescription)
//            }else {
//                print(objects)
//            }
//        }
        
    }
    
    @IBAction func sinBtn(_ sender: Any) {
        if usrTF.text! != "" && passTF.text! != "" {
            
            PFUser.logInWithUsername(inBackground: passTF.text!, password: passTF.text!) { (user , error) in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!!")
                }else {
                    
                }
            }
            
        }else {
            self.makeAlert(title: "Error", message: "Username/Password ??")
        }
        
    }
    
    @IBAction func supBtn(_ sender: Any) {
        
        if usrTF.text != nil && passTF.text != nil{
            
            let user = PFUser()
            user.username = usrTF.text!
            user.password = passTF.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!!")
                }else{
                    //Segue 
                }
            }
            
        }else {
            makeAlert(title: "Error", message: "Username/Password ??")
        }
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let alertActionBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(alertActionBtn)
        self.present(alert, animated: true, completion: nil)
        
    }
    

}

