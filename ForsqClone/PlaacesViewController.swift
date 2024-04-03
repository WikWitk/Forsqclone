//
//  PlaacesViewController.swift
//  ForsqClone
//
//  Created by Wiktor Witkowski on 11/01/2024.
//

import UIKit
import Parse


class PlaacesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var placeNameArr = [String]()
    var idArray = [String]()
    var selectedPlaceId = ""
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNewPlace))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title:"Log Out", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logOut))
        getDatafromParsebase()
        
    }
    @objc func addNewPlace(){
        self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
        
    }
    
    @objc func logOut(){
        
        PFUser.logOutInBackground { (error) in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!!")
                
            }else{
                self.performSegue(withIdentifier: "toVC", sender: nil)
                
            }
        }
        
    }
    
    func getDatafromParsebase(){
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            }else{
                if objects != nil {
                    
                    self.placeNameArr.removeAll(keepingCapacity: false)
                    self.idArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String {
                            if let placeId = object.objectId {
                                self.placeNameArr.append(placeName)
                                self.idArray.append(placeId)
                            }
                            
                            
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.chosenPlaceId = selectedPlaceId
        }
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = idArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
        func makeAlert(title: String, message: String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            let alertActionBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(alertActionBtn)
            self.present(alert, animated: true, completion: nil)
            
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            cell.textLabel!.text = placeNameArr[indexPath.row]
            return cell
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return placeNameArr.count
        }
        
        
        
        
        
    }

