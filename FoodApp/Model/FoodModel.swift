//
//  FoodModel.swift
//  FoodApp
//
//  Created by Payal Kandlur on 17/02/21.
//

import UIKit

class FoodModel {
    
    var idMeal: String = ""
    var strMeal: String = ""
    var strCategory: String = ""
    
    init(idMeal: String, strMeal: String, strCategory: String) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strCategory = strCategory
    }
}

