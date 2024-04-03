//
//  AddPlaceViewController.swift
//  ForsqClone
//
//  Created by Wiktor Witkowski on 22/01/2024.
//

import UIKit

class AddPlaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeNameTF: UITextField!
    @IBOutlet weak var placeTypeTF: UITextField!
    @IBOutlet weak var placeAtmosphereTF: UITextField!
    
    @IBOutlet weak var placeView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placeView.isUserInteractionEnabled = true
        let addImage = UITapGestureRecognizer(target: self, action: #selector(addImage))
        placeView.addGestureRecognizer(addImage)
    }
    

    @IBAction func nextBtn(_ sender: Any) {
        if placeNameTF.text != "" && placeTypeTF.text != "" && placeTypeTF.text != "" {
            if let chosenImage = placeView.image {
                PlaceModel.sharedInstance.placeName = placeNameTF.text!
                PlaceModel.sharedInstance.placeType = placeTypeTF.text!
                PlaceModel.sharedInstance.placeAtmosphere = placeAtmosphereTF.text!
                PlaceModel.sharedInstance.placeImage = chosenImage
                
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)
        }else{
            let alert = UIAlertController(title: "Error", message: "Empty field", preferredStyle: UIAlertController.Style.alert)
            let alertButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(alertButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func addImage(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
}
