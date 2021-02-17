//
//  FoodListViewController.swift
//  FoodApp
//
//  Created by Payal Kandlur on 17/02/21.
//

import UIKit
import Foundation

class FoodListViewController: UIViewController {

    var searchResults: [FoodModel] = []
    var filteredData: [FoodModel] = [] //filtered array
    var foodSearch = NetworkService()
   
    static let sharedInstance = FoodListViewController()
    var food = FoodModel(idMeal: "", strMeal: "", strCategory: "")
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.register(CustomCell.nib, forCellReuseIdentifier: "CustomCellView")
        
        filteredData = searchResults
        foodSearch.getFoodList() { [self] results, errorMessage in
            if let results = results {
                self.searchResults = results
                self.tableView.reloadData()
            }
        }
    }
}


extension FoodListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellView",for: indexPath) as! CustomCell
        
        food = self.searchResults[indexPath.row]
        cell.display(item: food)
        cell.favourite.addTarget(self, action: #selector(self.addFav), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    @objc func addFav(sender: UIButton) {
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let cellIndexPath = self.tableView.indexPathForRow(at: pointInTable)
        
        let cell = self.tableView.cellForRow(at: NSIndexPath.init(row: cellIndexPath!.row, section: 0) as IndexPath) as! CustomCell

        if CommonUtils.sharedInstance.favFood.contains(cell.mealCat.text ?? "") {
            print("Already in favourites")
            //do nothing as of now
            
        }else{
            CommonUtils.sharedInstance.favFood.append(cell.mealCat.text ?? "")
            cell.favourite.setImage(UIImage(systemName: "heart.fill"), for: .selected)
            let dialogMessage = UIAlertController(title: "Added to favourites", message: "Check the favourites section", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
                cell.favourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            })
            
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)

        }
        
        tableView.reloadData()
        
    }
}
