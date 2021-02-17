//
//  SearchViewController.swift
//  FoodApp
//
//  Created by Payal Kandlur on 17/02/21.
//

import UIKit

class SearchViewController: UIViewController {

    var searchResults: [FoodModel] = []
    var filteredData: [FoodModel] = [] //filtered array
    var foodSearch = NetworkService()
    var searchActive : Bool = false
    var searchString = ""
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CustomCell.nib, forCellReuseIdentifier: "CustomCellView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        filteredData = searchResults
        foodSearch.getSearchResults() { [self] results, errorMessage in
            if let results = results {
                self.searchResults = results
                self.tableView.reloadData()
            }
        }
    }

}

//searchBar
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = true
        //display searchResults array when search text is empty
        guard !searchText.isEmpty else{
            filteredData = searchResults
            self.tableView.reloadData()
            return
        }

        filteredData = searchResults.filter({ (FoodModel) -> Bool in
            FoodModel.strCategory.contains(searchText.capitalized.trimmingCharacters(in: CharacterSet.whitespaces))
        })
        print (searchText.capitalized.trimmingCharacters(in: CharacterSet.whitespaces))
        self.tableView.reloadData()
        
        
    }
    
    //dismiss keyboard when search button on keyboard is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.endEditing(true)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellView",for: indexPath) as! CustomCell
        
        let food = self.filteredData[indexPath.row]
        cell.display(item: food)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

