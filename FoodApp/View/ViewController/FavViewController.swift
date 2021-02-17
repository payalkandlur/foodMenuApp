//
//  ViewController.swift
//  FoodApp
//
//  Created by Payal Kandlur on 17/02/21.
//

import UIKit

class FavViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(CustomCell.nib, forCellReuseIdentifier: "CustomCellView")
        
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}


//tableView
extension FavViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommonUtils.sharedInstance.favFood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellView",for: indexPath) as! CustomCell
        cell.favourite.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        let food = CommonUtils.sharedInstance.favFood[indexPath.row]
        cell.displayFav(item: food)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

