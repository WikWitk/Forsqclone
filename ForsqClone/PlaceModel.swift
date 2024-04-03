//
//  PlaceModel.swift
//  ForsqClone
//
//  Created by Wiktor Witkowski on 22/01/2024.
//

import Foundation
import UIKit

class PlaceModel{
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init(){
        
    }
    
    
}
