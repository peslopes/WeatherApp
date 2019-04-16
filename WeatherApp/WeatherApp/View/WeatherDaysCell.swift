//
//  WeatherDaysCell.swift
//  WeatherApp
//
//  Created by Pedro Enrique Sobrosa Lopes on 15/04/19.
//  Copyright © 2019 WeatherApp. All rights reserved.
//

import UIKit

class WeatherDaysCell: UITableViewCell {
    
    
    @IBOutlet weak var weatherStateImage: UIImageView!
    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
