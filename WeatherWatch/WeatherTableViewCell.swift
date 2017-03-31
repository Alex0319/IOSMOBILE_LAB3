//
//  WeatherTableViewCell.swift
//  WeatherWatch
//
//  Created by Admin on 31.03.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTemperatureValue: UILabel!
    @IBOutlet weak var lblCityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
