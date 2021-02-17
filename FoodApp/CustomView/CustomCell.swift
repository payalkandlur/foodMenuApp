//
//  CustomCell.swift
//  FoodApp
//
//  Created by Payal Kandlur on 17/02/21.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var mealId: UILabel!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealCat: UILabel!
    @IBOutlet weak var favourite: UIButton!
    static let sharedInstance = CustomCell()
    var fav : [FoodModel] = []
    static var nib:UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func display(item: FoodModel) {
        mealId.text = item.idMeal
        mealName.text = item.strMeal
        mealCat.text = item.strCategory
    }
    
    func displayFav(item: String) {
        mealId.text = ""
        mealName.text = ""
        mealCat.text = item
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
