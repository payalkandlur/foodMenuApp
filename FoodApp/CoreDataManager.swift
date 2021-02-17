//
//  CoreData.swift
//  FoodApp
//
//  Created by Payal Kandlur on 17/02/21.
//

import UIKit

class CoreDataManager: UIViewController {

    static let sharedInstance = CoreDataManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadIsFavorite(shoe_ID: String) -> Bool{
        
        let request: NSFetchRequest<Project> = NSFetchRequest< Project >(entityName: "Project")
        var favorite = Bool()
        
        do {
            let sneaksObject = try context.fetch(request)
            
            
            for i in 0..<sneaksObject.count {
                if shoe_ID == sneaksObject[i].shoe_ID {
                    favorite = sneaksObject[i].isFavorite
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        return favorite
    }
    
    func updateIsFavorite(shoe_ID: String, isFavorite: Bool) {
        
        let request: NSFetchRequest< Project > = NSFetchRequest< Project >(entityName: "Project")
        do {
            let sneaksObject = try context.fetch(request)
            
            for i in 0..<sneaksObject.count {
                if shoe_ID == sneaksObject[i].shoe_ID {
                    sneaksObject[i].setValue(isFavorite, forKey: "isFavorite")
                    saveContext()
                }
            }
            saveContext()
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
