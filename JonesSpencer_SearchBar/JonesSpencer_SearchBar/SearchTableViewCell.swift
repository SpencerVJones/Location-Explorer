//  SearchTableViewCell.swift
//  JonesSpencer_SearchBar
//  Created by Spencer Jones on 4/27/24.

import UIKit

class SearchTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet var cityStateLabel: UILabel!
    @IBOutlet var popLabel: UILabel!
    @IBOutlet var zipLabel: UILabel!
    @IBOutlet var coordinatesLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
