//
//  NetworkService.swift
//  FoodApp
//
//  Created by Payal Kandlur on 17/02/21.
//

import UIKit

class NetworkService: UIViewController {
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var foodList: [FoodModel] = []
    var errorMessage = ""
    
    var idMeal: String = ""
    var strMeal: String  = ""
    var strCategory: String = ""
    
    
    typealias JSONDictionary = [String: Any]
    
    //get the sreahc results
    func getSearchResults(completion: @escaping ([FoodModel]?, String) -> Void ) {
        dataTask?.cancel()
        guard let url = URL(string : "https://www.themealdb.com/api/json/v1/1/list.php?c=list")
        else { return }
        dataTask = defaultSession.dataTask(with: url) { [self] data, response, error in
            defer {
                self.dataTask = nil
            }
            if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                            
                var response: JSONDictionary?
                self.foodList.removeAll()
                
                do {
                    response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
                } catch {
                    print(error)
                }
                
                guard let array = response!["meals"] as? [Any] else {
                    return
                }
                                
                for trackDictionary in array {
                    
                    if (trackDictionary as? Dictionary<String, Any>) != nil {
                        for (key,value) in trackDictionary as! Dictionary<String,Any> {
                            if key == "idMeal" {
                                let ov = value
                                self.idMeal = ov as? String ?? ""
                            }
                            if key == "strMeal" {
                                let titl = value
                                self.strMeal = titl as? String ?? ""
                            }
                            if key == "strCategory" {
                                let rd = value
                                self.strCategory = rd as? String ?? ""
                            }
                        }
                    }
                    
                    self.foodList.append(FoodModel(idMeal: self.idMeal, strMeal: self.strMeal , strCategory: self.strCategory))
                }
                
                DispatchQueue.main.async {
                    completion(self.foodList, self.errorMessage)
                }
            }
        }
        dataTask?.resume()
    }
    
    //get the food list
    func getFoodList(completion: @escaping ([FoodModel]?, String) -> Void ) {
        dataTask?.cancel()
        guard let url = URL(string : "https://www.themealdb.com/api/json/v1/1/list.php?c=list")
        else { return }
        dataTask = defaultSession.dataTask(with: url) { [self] data, response, error in
            defer {
                self.dataTask = nil
            }
            if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                                
                var response: JSONDictionary?
                self.foodList.removeAll()
                
                do {
                    response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
                } catch {
                    print(error)
                }
                
                guard let array = response!["meals"] as? [Any] else {
                    return
                }
                                
                for trackDictionary in array {
                    
                    if (trackDictionary as? Dictionary<String, Any>) != nil {
                        for (key,value) in trackDictionary as! Dictionary<String,Any> {
                            if key == "idMeal" {
                                let ov = value
                                self.idMeal = ov as? String ?? ""
                            }
                            if key == "strMeal" {
                                let titl = value
                                self.strMeal = titl as? String ?? ""
                            }
                            if key == "strCategory" {
                                let rd = value
                                self.strCategory = rd as? String ?? ""
                            }
                        }
                    }
                    
                    self.foodList.append(FoodModel(idMeal: self.idMeal, strMeal: self.strMeal , strCategory: self.strCategory))
                }
                
                DispatchQueue.main.async {
                    completion(self.foodList, self.errorMessage)
                }
            }
        }
        dataTask?.resume()
    }
}
